function [d] = dD2daydaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDday(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDday(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdaydaz(X,t,post1,post2));
end

