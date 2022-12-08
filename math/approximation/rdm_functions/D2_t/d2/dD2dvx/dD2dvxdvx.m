function [d] = dD2dvxdvx(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvx(X,t,post1,post2);
    d = 2*(dDdvx(X,t,post1,post2) * dDdvx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvxdvx(X,t,post1,post2));
end

