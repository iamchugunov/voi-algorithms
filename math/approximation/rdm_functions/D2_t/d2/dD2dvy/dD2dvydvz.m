function [d] = dD2dvydvz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvy(X,t,post1,post2);
    d = 2*(dDdvz(X,t,post1,post2) * dDdvy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvydvz(X,t,post1,post2));
end

