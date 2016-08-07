%%this program creates ER graphs and compares MPL as function of network
%mass(number of nodes)
%clear; clc;
%%
tic;
N = 200:200:4000;  
k = 6;
num_of_simulations = 100;
MPL_v = zeros(1,length(N));
mpl = zeros(1,num_of_simulations)
idx = 1;

for n = N
    n
    p = k/n;
    
    for j=1:num_of_simulations
        M = create_ER_Graph(n,p);
        sp = graphallshortestpaths(M,'directed',false);
        sp(~isfinite(sp)) = [];        %% avoiding inf values
        sp = sp(sp ~= 0);                  %% ignoring zeros
        mpl(j) = mean(mean(sp));
    end
    MPL_v(idx) = mean(mpl);
    idx = idx + 1;
end
toc;
figure;
plot(N , MPL_v)
title('ER network -- MPL vs. mass , k = 6 , regular scale')



figure;
plot(N,MPL_v);
title('ER network -- MPL vs. mass , k = 6 , semilog scale' );
xlabel('n'); ylabel('MPL');

%dlmwrite('MPL_100sim_k_6.txt' , N , MPL_v  );

p = polyfit(log(N),MPL_v,1)
hold on;
f = @(x) p(1) * log(x) + p(2);
fun = f(N);
plot (N,fun , 'r');
set(gca, 'Xscale' , 'log')

legend('simulation' , 'fit')
formatspec = 'slope =  %f ';
str = sprintf(formatspec , p(1));

text(2*10^2,1,str)