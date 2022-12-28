function [d] = dP2dzday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzday(X,k,post,config));
end

