function [d] = dD2dzdz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdz(X,t,post1,post2);
    d = 2*(dDdz(X,t,post1,post2) * dDdz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdzdz(X,t,post1,post2));
end

