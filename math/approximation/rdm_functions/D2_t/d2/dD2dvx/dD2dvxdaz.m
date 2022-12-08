function [d] = dD2dvxdaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvx(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdvx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvxdaz(X,t,post1,post2));
end

