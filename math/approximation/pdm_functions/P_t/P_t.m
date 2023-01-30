function [P] = P_t(X, k, post, config)
    P = R_t(X, k, post, config) + X.T + X.dt * (k - 1);
end

