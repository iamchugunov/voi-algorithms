function [z] = Z_t(X, k, config)
    t = X.dt * (k - 1)/config.c;
    z = X.z + X.vz * t + X.az * t^2/2;
end