function [d] = dD2dyday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdy(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDdy(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdyday(X,t,post1,post2));
end

