function [d] = dP2dTday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTday(X,k,post,config));
end

