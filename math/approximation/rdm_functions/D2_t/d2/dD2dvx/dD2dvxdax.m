function [d] = dD2dvxdax(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvx(X,t,post1,post2);
    d = 2*(dDdax(X,t,post1,post2) * dDdvx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvxdax(X,t,post1,post2));
end

