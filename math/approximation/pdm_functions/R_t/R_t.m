function [R] = R_t(X, k, post, config)
    x = X_t(X, k, config);
    y = Y_t(X, k, config);
    z = Z_t(X, k, config);
    R = sqrt((x - post(1))^2 + (y - post(2))^2 + (z - post(3))^2);
end

