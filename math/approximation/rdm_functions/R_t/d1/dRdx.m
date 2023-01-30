function [d] = dRdx(X, t, post)
    d = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdx(X,t);
end



