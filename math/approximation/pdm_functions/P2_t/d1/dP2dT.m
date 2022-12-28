function [d] = dP2dT(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
end

