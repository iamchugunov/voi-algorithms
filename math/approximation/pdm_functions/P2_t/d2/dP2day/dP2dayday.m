function [d] = dP2dayday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPday(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPday(X,k,post,config) + P_t(X, k, post, config)*dPdayday(X,k,post,config));
end

