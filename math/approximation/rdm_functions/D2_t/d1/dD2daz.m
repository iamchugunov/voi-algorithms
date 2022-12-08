function [d] = dD2daz(X, t, post1, post2)
    d = 2*D_t(X,t,post1,post2)*dDdaz(X,t,post1,post2);
end

