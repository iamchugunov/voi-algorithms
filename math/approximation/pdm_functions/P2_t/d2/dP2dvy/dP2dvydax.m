function [d] = dP2dvydax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvy(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdvy(X,k,post,config) + P_t(X, k, post, config)*dPdvydax(X,k,post,config));
end

