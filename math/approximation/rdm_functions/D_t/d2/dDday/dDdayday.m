function [d] = dDdayday(X, t, post1, post2)
%     d = dRday(X,t,post1) - dRday(X,t,post2);
    d = dRdayday(X,t,post1) - dRdayday(X,t,post2);
end
