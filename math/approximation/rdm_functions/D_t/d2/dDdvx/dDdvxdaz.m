function [d] = dDdvxdaz(X, t, post1, post2)
%     d = dRdvx(X,t,post1) - dRdvx(X,t,post2);
    d = dRdvxdaz(X,t,post1) - dRdvxdaz(X,t,post2);
end
