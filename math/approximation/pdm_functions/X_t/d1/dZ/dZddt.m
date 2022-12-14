function [d] = dZddt(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = X.vz + X.az * t;
end