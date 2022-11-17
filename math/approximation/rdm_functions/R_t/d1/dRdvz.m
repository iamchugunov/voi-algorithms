function [d] = dRdvz(X, t, post)
    d = (Z_t(X,t) - post(3))/R_t(X,t,post) * dZdvz(X,t);
end