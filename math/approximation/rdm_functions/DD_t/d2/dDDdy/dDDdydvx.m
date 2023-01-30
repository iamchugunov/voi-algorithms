function [d] = dDDdydvx(X, t, post1, post2, post3)
%     d = dDdy(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdy(X,t,post1,post3);
    s1 = dDdydvx(X,t,post1,post2) * D_t(X,t,post1,post3);
    s2 = dDdy(X,t,post1,post2) * dDdvx(X,t,post1,post3);
    s3 = dDdvx(X,t,post1,post2) * dDdy(X,t,post1,post3);
    s4 = D_t(X,t,post1,post2) * dDdydvx(X,t,post1,post3);
    d = s1 + s2 + s3 + s4;
end
