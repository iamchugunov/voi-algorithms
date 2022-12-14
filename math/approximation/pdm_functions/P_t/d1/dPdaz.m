function [d] = dPdaz(X, k, post, config)
%     P = R_t(X, k, post, config) + X.T + X.dt * (k - 1);
    d = dRdaz(X,k,post,config);
end

