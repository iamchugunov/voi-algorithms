function [d] = dDdvxdax(X, t, post1, post2)
%     d = dRdvx(X,t,post1) - dRdvx(X,t,post2);
    d = dRdvxdax(X,t,post1) - dRdvxdax(X,t,post2);
end
