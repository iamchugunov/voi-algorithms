function [d] = dRdy(X, t, post)
    d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dYdy(X,t);
end