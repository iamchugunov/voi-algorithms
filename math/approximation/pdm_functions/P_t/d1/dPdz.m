function [d] = dPdz(X, k, post, config)
%     P = R_t(X, k, post, config) + X.T + X.dt * (k - 1);
    d = dRdz(X,k,post,config);
end

