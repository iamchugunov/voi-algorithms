function [d] = dP2daxday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdax(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdax(X,k,post,config) + P_t(X, k, post, config)*dPdaxday(X,k,post,config));
end

