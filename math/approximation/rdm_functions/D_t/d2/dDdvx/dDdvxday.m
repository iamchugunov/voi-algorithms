function [d] = dDdvxday(X, t, post1, post2)
%     d = dRdvx(X,t,post1) - dRdvx(X,t,post2);
    d = dRdvxday(X,t,post1) - dRdvxday(X,t,post2);
end
