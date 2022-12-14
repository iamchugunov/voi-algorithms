function [x] = X_t(X, k, config)
    t = X.dt * (k - 1)/config.c;
    x = X.x + X.vx * t + X.ax * t^2/2;
end