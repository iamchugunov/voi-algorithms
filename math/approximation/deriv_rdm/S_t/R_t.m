function [R] = R_t(X, t, post, order)
    x = X_t(X, t, order);
    y = Y_t(X, t, order);
    z = Z_t(X, t, order);
    R = sqrt((x - post(1))^2 + (y - post(2))^2 + (z - post(3))^2);
end

