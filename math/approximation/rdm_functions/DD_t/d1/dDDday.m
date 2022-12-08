function [d] = dDDday(X, t, post1, post2, post3)
%     D = D_t(X,t,post1,post2) * D_t(X,t,post1,post3);
    d = dDday(X,t,post1,post2) * D_t(X,t,post1,post3) + D_t(X,t,post1,post2) * dDday(X,t,post1,post3);
end
