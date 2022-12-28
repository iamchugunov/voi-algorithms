function [d] = dP2dvyday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvy(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdvy(X,k,post,config) + P_t(X, k, post, config)*dPdvyday(X,k,post,config));
end

