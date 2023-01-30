function [d] = dD2dvydvy(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvy(X,t,post1,post2);
    d = 2*(dDdvy(X,t,post1,post2) * dDdvy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvydvy(X,t,post1,post2));
end

