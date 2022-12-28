function [d] = dP2dvy(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdvy(X,k,post,config);
end

