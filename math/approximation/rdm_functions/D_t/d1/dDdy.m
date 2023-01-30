function [d] = dDdy(X, t, post1, post2)
    d = dRdy(X,t,post1) - dRdy(X,t,post2);
end
