function [d] = dDdax(X, t, post1, post2)
    d = dRdax(X,t,post1) - dRdax(X,t,post2);
end
