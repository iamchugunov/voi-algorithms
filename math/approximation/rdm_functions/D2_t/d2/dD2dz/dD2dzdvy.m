function [d] = dD2dzdvy(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdz(X,t,post1,post2);
    d = 2*(dDdvy(X,t,post1,post2) * dDdz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdzdvy(X,t,post1,post2));
end

