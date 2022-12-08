function [d] = dDdaxdax(X, t, post1, post2)
%     d = dRdax(X,t,post1) - dRdax(X,t,post2);
    d = dRdaxdax(X,t,post1) - dRdaxdax(X,t,post2);
end
