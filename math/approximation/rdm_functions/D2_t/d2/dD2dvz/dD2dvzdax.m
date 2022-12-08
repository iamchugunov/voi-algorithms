function [d] = dD2dvzdax(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvz(X,t,post1,post2);
    d = 2*(dDdax(X,t,post1,post2) * dDdvz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvzdax(X,t,post1,post2));
end

