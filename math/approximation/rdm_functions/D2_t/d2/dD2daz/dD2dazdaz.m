function [d] = dD2dazdaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdaz(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdaz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdazdaz(X,t,post1,post2));
end

