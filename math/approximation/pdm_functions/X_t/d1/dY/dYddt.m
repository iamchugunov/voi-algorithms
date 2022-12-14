function [d] = dYddt(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = X.vy + X.ay * t;
end