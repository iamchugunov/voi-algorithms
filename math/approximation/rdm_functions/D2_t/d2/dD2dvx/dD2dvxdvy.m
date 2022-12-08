function [d] = dD2dvxdvy(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvx(X,t,post1,post2);
    d = 2*(dDdvy(X,t,post1,post2) * dDdvx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvxdvy(X,t,post1,post2));
end

