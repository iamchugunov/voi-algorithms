function [d] = dP2dvz(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdvz(X,k,post,config);
end

