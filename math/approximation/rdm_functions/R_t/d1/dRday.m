function [d] = dRday(X, t, post)
    d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dYday(X,t);
end