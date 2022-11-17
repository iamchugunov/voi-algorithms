function [d] = dDdvxdvz(X, t, post1, post2)
%     d = dRdvx(X,t,post1) - dRdvx(X,t,post2);
    d = dRdvxdvz(X,t,post1) - dRdvxdvz(X,t,post2);
end
