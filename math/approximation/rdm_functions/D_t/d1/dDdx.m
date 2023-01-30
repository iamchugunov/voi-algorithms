function [d] = dDdx(X, t, post1, post2)
    d = dRdx(X,t,post1) - dRdx(X,t,post2);
end
