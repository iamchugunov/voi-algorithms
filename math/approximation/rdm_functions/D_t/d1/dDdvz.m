function [d] = dDdvz(X, t, post1, post2)
    d = dRdvz(X,t,post1) - dRdvz(X,t,post2);
end
