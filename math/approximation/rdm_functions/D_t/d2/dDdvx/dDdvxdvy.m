function [d] = dDdvxdvy(X, t, post1, post2)
%     d = dRdvx(X,t,post1) - dRdvx(X,t,post2);
    d = dRdvxdvy(X,t,post1) - dRdvxdvy(X,t,post2);
end
