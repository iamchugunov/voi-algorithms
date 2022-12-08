function [d] = dRdax(X, t, post)
    d = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdax(X,t);
end