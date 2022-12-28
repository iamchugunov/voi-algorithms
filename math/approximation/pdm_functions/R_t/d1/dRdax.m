function [d] = dRdax(X, k, post, config)
    d = (X_t(X,k,config)-post(1))/R_t(X,k,post,config)*dXdax(X,k,config);
end



