function [d] = dDdaydaz(X, t, post1, post2)
%     d = dRday(X,t,post1) - dRday(X,t,post2);
    d = dRdaydaz(X,t,post1) - dRdaydaz(X,t,post2);
end
