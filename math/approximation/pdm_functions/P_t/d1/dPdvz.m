function [d] = dPdvz(X, k, post, config)
%     P = R_t(X, k, post, config) + X.T + X.dt * (k - 1);
    d = dRdvz(X,k,post,config);
end

