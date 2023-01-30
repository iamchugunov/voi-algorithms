function [d] = dDDdaxday(X, t, post1, post2, post3)
%     d = dDdax(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDdax(X,t,post1,post3);
    s1 = dDdaxday(X,t,post1,post2) * D_t(X,t,post1,post3);
    s2 = dDdax(X,t,post1,post2) * dDday(X,t,post1,post3);
    s3 = dDday(X,t,post1,post2) * dDdax(X,t,post1,post3);
    s4 = D_t(X,t,post1,post2) * dDdaxday(X,t,post1,post3);
    d = s1 + s2 + s3 + s4;
end
