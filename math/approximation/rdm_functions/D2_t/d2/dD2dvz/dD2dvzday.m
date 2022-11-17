function [d] = dD2dvzday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvz(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDdvz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvzday(X,t,post1,post2));
end

