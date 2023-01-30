function [d] = dRdaz(X, t, post)
    d = (Z_t(X,t) - post(3))/R_t(X,t,post) * dZdaz(X,t);
end