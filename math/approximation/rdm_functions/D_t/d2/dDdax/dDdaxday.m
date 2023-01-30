function [d] = dDdaxday(X, t, post1, post2)
%     d = dRdax(X,t,post1) - dRdax(X,t,post2);
    d = dRdaxday(X,t,post1) - dRdaxday(X,t,post2);
end
