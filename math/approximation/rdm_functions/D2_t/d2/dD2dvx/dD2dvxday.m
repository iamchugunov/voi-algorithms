function [d] = dD2dvxday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvx(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDdvx(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvxday(X,t,post1,post2));
end

