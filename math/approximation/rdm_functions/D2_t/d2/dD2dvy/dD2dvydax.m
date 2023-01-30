function [d] = dD2dvydax(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvy(X,t,post1,post2);
    d = 2*(dDdax(X,t,post1,post2) * dDdvy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvydax(X,t,post1,post2));
end

