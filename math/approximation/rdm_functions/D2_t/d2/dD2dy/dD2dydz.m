function [d] = dD2dydz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdy(X,t,post1,post2);
    d = 2*(dDdz(X,t,post1,post2) * dDdy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdydz(X,t,post1,post2));
end

