function [d] = dYddtddt(X, k, config)
%     d = (X.vy + X.ay * t) * (k-1)/config.c;
    t = X.dt * (k - 1)/config.c;
    d = X.ay * (k - 1)/config.c * (k - 1)/config.c;
end