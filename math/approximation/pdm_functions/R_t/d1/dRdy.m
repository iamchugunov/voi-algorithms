function [d] = dRdy(X, k, post, config)
    d = (Y_t(X,k,config)-post(2))/R_t(X,k,post,config)*dYdy(X,k,config);
end



