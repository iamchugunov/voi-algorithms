function [d] = dD2day(X, t, post1, post2)
    d = 2*D_t(X,t,post1,post2)*dDday(X,t,post1,post2);
end

