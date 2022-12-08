function [d] = dD2dzday(X, t, post1, post2)
%     d = 2*D_t(X,t,post1,post2)*dDdz(X,t,post1,post2);
    d = 2*(dDday(X,t,post1,post2) * dDdz(X,t,post1,post2) + D_t(X,t,post1,post2) * dDdzday(X,t,post1,post2));
end

