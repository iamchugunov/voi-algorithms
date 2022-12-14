function [d] = dXddtday(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = t;
end