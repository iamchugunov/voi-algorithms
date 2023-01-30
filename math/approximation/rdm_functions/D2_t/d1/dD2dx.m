function [d] = dD2dx(X, t, post1, post2)
    d = 2*D_t(X,t,post1,post2)*dDdx(X,t,post1,post2);
end

