function [z] = Z_t(X, t)
    z = X.z + X.vz * t + X.az * t^2/2;
end

