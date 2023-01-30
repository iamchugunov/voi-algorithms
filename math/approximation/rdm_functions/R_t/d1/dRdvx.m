function [d] = dRdvx(X, t, post)
    d = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdvx(X,t);
end