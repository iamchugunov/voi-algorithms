function [y] = Y_t(X, k, config)
    t = X.dt * (k - 1)/config.c;
    y = X.y + X.vy * t + X.ay * t^2/2;
end