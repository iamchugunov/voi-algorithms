function [d] = dP2ddt(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
end

