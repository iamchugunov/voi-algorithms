function [d] = dDDdy(X, t, post1, post2, post3)
%     D = D_t(X,t,post1,post2) * D_t(X,t,post1,post3);
    d = dDdy(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdy(X,t,post1,post3);
end
