function [d] = dPdT(X, k, post, config)
%     P = R_t(X, k, post, config) + X.T + X.dt * (k - 1);
    d = dRdT(X,k,post,config) + 1;
end

