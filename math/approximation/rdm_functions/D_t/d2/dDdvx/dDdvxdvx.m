function [d] = dDdvxdvx(X, t, post1, post2)
%     d = dRdvx(X,t,post1) - dRdvx(X,t,post2);
    d = dRdvxdvx(X,t,post1) - dRdvxdvx(X,t,post2);
end
