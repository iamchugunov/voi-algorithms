function [d] = dYddtddt(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = X.ay;
end