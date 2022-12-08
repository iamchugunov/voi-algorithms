function [d] = dD2dax(X, t, post1, post2)
    d = 2*D_t(X,t,post1,post2)*dDdax(X,t,post1,post2);
end

