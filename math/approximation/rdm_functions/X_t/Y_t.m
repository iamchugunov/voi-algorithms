function [y] = Y_t(X, t)
    y = X.y + X.vy * t + X.ay * t^2/2;
end

