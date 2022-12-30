function [d] = dZddtdaz(X, k, config)
%     d = (X.vz + X.az* t) * (k-1)/config.c;
    t = X.dt * (k - 1)/config.c;
    d = t* (k - 1)/config.c;
end