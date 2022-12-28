function [d] = dRdvy(X, k, post, config)
    d = (Y_t(X,k,config)-post(2))/R_t(X,k,post,config)*dYdvy(X,k,config);
end



