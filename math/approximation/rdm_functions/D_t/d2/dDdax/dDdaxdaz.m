function [d] = dDdaxdaz(X, t, post1, post2)
%     d = dRdax(X,t,post1) - dRdax(X,t,post2);
    d = dRdaxdaz(X,t,post1) - dRdaxdaz(X,t,post2);
end
