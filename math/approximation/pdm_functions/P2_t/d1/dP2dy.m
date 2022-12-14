function [d] = dP2dy(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
end

