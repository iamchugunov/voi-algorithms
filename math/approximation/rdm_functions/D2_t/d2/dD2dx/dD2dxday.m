function [d] = dD2dxday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdx(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDdx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdxday(X,t,post1,post2));
end

