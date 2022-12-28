function [d] = dZddtdvz(X, k, config)
%     d = (X.vz + X.az* t) * (k-1)/config.c;
    t = X.dt * (k - 1)/config.c;
    d = (k - 1)/config.c;
end