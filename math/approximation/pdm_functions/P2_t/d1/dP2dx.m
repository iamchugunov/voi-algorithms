function [d] = dP2dx(X, k, post, config)
%     P = P_t(X, k, post, config)^2;
    d = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
end

