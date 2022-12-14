function [d] = dRdz(X, k, post, config)
    d = (Z_t(X,k,config)-post(3))/R_t(X,k,post,config)*dZdz(X,k,config);
end



