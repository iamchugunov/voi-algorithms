function [d] = dD2dvydaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvy(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdvy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvydaz(X,t,post1,post2));
end

