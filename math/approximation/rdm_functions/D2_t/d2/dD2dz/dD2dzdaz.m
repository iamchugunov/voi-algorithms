function [d] = dD2dzdaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdz(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdzdaz(X,t,post1,post2));
end

