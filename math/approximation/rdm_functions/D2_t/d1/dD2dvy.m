function [d] = dD2dvy(X, t, post1, post2)
    d = 2*D_t(X,t,post1,post2)*dDdvy(X,t,post1,post2);
end

