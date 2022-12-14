function [d] = dP2dvx(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdvx(X,k,post,config);
end

