function [d] = dD2dydax(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdy(X,t,post1,post2);
    d = 2*(dDdax(X,t,post1,post2) * dDdy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdydax(X,t,post1,post2));
end

