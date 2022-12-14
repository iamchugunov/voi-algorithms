function [d] = dZddtddt(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = X.az;
end