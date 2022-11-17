function [x] = X_t(X, t)
    x = X.x + X.vx * t + X.ax * t^2/2;
end