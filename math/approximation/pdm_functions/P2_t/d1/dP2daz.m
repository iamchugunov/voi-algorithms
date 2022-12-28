function [d] = dP2daz(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdaz(X,k,post,config);
end

