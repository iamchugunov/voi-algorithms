function [d] = dP2dyday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdyday(X,k,post,config));
end

