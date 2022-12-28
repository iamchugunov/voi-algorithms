function [d] = dRdx(X, k, post, config)
    d = (X_t(X,k,config)-post(1))/R_t(X,k,post,config)*dXdx(X,k,config);
end



