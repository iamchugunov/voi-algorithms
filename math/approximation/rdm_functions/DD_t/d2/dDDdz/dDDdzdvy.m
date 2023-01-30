function [d] = dDDdzdvy(X, t, post1, post2, post3)
%     d = dDdz(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdz(X,t,post1,post3);
    s1 = dDdzdvy(X,t,post1,post2) * D_t(X,t,post1,post3);
    s2 = dDdz(X,t,post1,post2) * dDdvy(X,t,post1,post3);
    s3 = dDdvy(X,t,post1,post2) * dDdz(X,t,post1,post3);
    s4 = D_t(X,t,post1,post2) * dDdzdvy(X,t,post1,post3);
    d = s1 + s2 + s3 + s4;
end
