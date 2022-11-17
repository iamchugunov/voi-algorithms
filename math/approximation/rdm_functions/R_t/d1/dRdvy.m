function [d] = dRdvy(X, t, post)
    d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dYdvy(X,t);
end