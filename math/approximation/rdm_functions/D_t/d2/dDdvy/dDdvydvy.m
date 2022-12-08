function [d] = dDdvydvy(X, t, post1, post2)
%     d = dRdvy(X,t,post1) - dRdvy(X,t,post2);
    d = dRdvydvy(X,t,post1) - dRdvydvy(X,t,post2);
end
