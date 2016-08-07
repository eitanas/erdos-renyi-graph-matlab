function ER = create_ER_Graph(n,p)
rng(0);
ER = sprand(n,n,p);
ER = triu(ER);
ER = ER + ER';

%bad and slow way to do this - 
%rng(0);
%ER = zeros(n,n);
%for i=1:n
%    for j = i+1:n
%       rnd = rand(1);
%       if p > rnd
%           ER(i,j) = 1;
%       end
%    end
%end


end