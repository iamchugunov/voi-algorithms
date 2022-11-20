function [d] = dDDdvydvz(X, t, post1, post2, post3)
%     d = dDdvy(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdvy(X,t,post1,post3);
    s1 = dDdvydvz(X,t,post1,post2) * D_t(X,t,post1,post3);
    s2 = dDdvy(X,t,post1,post2) * dDdvz(X,t,post1,post3);
    s3 = dDdvz(X,t,post1,post2) * dDdvy(X,t,post1,post3);
    s4 = D_t(X,t,post1,post2) * dDdvydvz(X,t,post1,post3);
    d = s1 + s2 + s3 + s4;
end
