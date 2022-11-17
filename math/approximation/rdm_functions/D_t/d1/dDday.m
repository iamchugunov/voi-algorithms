function [d] = dDday(X, t, post1, post2)
    d = dRday(X,t,post1) - dRday(X,t,post2);
end
