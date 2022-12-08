function [d] = dDDdxdvx(X, t, post1, post2, post3)
%     d = dDdx(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdx(X,t,post1,post3);
    s1 = dDdxdvx(X,t,post1,post2) * D_t(X,t,post1,post3);
    s2 = dDdx(X,t,post1,post2) * dDdvx(X,t,post1,post3);
    s3 = dDdvx(X,t,post1,post2) * dDdx(X,t,post1,post3);
    s4 = D_t(X,t,post1,post2) * dDdxdvx(X,t,post1,post3);
    d = s1 + s2 + s3 + s4;
end
