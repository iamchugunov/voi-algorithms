function [d] = dZddtddt(X, k, config)
%     d = (X.vz + X.az* t) * (k-1)/config.c;
    t = X.dt * (k - 1)/config.c;
    d = X.az * (k - 1)/config.c * (k - 1)/config.c;
end