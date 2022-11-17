function [d] = dDdvy(X, t, post1, post2)
    d = dRdvy(X,t,post1) - dRdvy(X,t,post2);
end
