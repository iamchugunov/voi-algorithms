function [d] = dD2dxdaz(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdx(X,t,post1,post2);
    d = 2*(dDdaz(X,t,post1,post2) * dDdx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdxdaz(X,t,post1,post2));
end

