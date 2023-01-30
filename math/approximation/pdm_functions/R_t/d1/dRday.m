function [d] = dRday(X, k, post, config)
    d = (Y_t(X,k,config)-post(2))/R_t(X,k,post,config)*dYday(X,k,config);
end



