function [d] = dD2dydy(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdy(X,t,post1,post2);
    d = 2*(dDdy(X,t,post1,post2) * dDdy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdydy(X,t,post1,post2));
end

