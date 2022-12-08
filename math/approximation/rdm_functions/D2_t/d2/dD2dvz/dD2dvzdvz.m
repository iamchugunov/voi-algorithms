function [d] = dD2dvzdvz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvz(X,t,post1,post2);
    d = 2*(dDdvz(X,t,post1,post2) * dDdvz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvzdvz(X,t,post1,post2));
end

