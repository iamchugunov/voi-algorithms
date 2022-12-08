function [d] = dD2dxdy(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdx(X,t,post1,post2);
    d = 2*(dDdy(X,t,post1,post2) * dDdx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdxdy(X,t,post1,post2));
end

