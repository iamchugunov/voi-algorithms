function [d] = dD2dayday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDday(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDday(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdayday(X,t,post1,post2));
end

