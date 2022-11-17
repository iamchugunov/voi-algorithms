function [d] = dRdz(X, t, post)
    d = (Z_t(X,t) - post(3))/R_t(X,t,post) * dZdz(X,t);
end