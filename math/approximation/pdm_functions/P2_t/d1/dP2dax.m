function [d] = dP2dax(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdax(X,k,post,config);
end

