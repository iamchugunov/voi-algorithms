function [d] = dD2dvzdaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvz(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdvz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvzdaz(X,t,post1,post2));
end

