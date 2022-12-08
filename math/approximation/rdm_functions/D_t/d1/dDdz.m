function [d] = dDdz(X, t, post1, post2)
    d = dRdz(X,t,post1) - dRdz(X,t,post2);
end
