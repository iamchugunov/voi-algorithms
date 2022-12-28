function [d] = dP2dvzday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvz(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdvz(X,k,post,config) + P_t(X, k, post, config)*dPdvzday(X,k,post,config));
end

