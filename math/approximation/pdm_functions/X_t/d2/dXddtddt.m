function [d] = dXddtddt(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = X.ax;
end