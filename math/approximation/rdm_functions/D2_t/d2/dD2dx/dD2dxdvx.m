function [d] = dD2dxdvx(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdx(X,t,post1,post2);
    d = 2*(dDdvx(X,t,post1,post2) * dDdx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdxdvx(X,t,post1,post2));
end

