function [d] = dXdax(X, k, config)
    t = X.dt * (k - 1)/config.c;
    d = t^2/2;
end

