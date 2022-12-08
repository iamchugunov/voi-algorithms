function [d] = dD2daxdaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdax(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdax(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdaxdaz(X,t,post1,post2));
end

