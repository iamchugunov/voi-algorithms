function [d] = dD2dydaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdy(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdydaz(X,t,post1,post2));
end

