function [d] = dD2dvz(X, t, post1, post2)
    d = 2*D_t(X,t,post1,post2)*dDdvz(X,t,post1,post2);
end

