function [R] = R_t(X, t, post)
    x = X_t(X, t);
    y = Y_t(X, t);
    z = Z_t(X, t);
    R = sqrt((x - post(1))^2 + (y - post(2))^2 + (z - post(3))^2);
end

