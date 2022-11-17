function [d] = dD2dzdax(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdz(X,t,post1,post2);
    d = 2*(dDdax(X,t,post1,post2) * dDdz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdzdax(X,t,post1,post2));
end

