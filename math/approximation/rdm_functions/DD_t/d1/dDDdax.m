function [d] = dDDdax(X, t, post1, post2, post3)
%     D = D_t(X,t,post1,post2) * D_t(X,t,post1,post3);
    d = dDdax(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdax(X,t,post1,post3);
end
