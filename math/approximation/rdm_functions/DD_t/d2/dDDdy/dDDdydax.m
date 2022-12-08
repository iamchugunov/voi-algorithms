function [d] = dDDdydax(X, t, post1, post2, post3)
%     d = dDdy(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdy(X,t,post1,post3);
    s1 = dDdydax(X,t,post1,post2) * D_t(X,t,post1,post3);
    s2 = dDdy(X,t,post1,post2) * dDdax(X,t,post1,post3);
    s3 = dDdax(X,t,post1,post2) * dDdy(X,t,post1,post3);
    s4 = D_t(X,t,post1,post2) * dDdydax(X,t,post1,post3);
    d = s1 + s2 + s3 + s4;
end
