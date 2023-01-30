function [d] = dD2dvyday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdvy(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDdvy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdvyday(X,t,post1,post2));
end

