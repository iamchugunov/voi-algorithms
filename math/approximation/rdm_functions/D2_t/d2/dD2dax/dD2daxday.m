function [d] = dD2daxday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdax(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDdax(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdaxday(X,t,post1,post2));
end

