function [d] = dDdaz(X, t, post1, post2)
    d = dRdaz(X,t,post1) - dRdaz(X,t,post2);
end
