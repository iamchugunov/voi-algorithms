function [d] = dZddtdvz(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = 1;
end