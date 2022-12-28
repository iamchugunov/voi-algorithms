function [d] = dP2dz(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
end

