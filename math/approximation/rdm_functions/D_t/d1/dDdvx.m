function [d] = dDdvx(X, t, post1, post2)
    d = dRdvx(X,t,post1) - dRdvx(X,t,post2);
end
