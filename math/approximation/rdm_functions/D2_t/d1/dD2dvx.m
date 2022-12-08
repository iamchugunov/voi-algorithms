function [d] = dD2dvx(X, t, post1, post2)
    d = 2*D_t(X,t,post1,post2)*dDdvx(X,t,post1,post2);
end

