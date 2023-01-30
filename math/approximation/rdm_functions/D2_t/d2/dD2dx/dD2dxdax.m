function [d] = dD2dxdax(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdx(X,t,post1,post2);
    d = 2*(dDdax(X,t,post1,post2) * dDdx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdxdax(X,t,post1,post2));
end

