function [d] = dRddt(X, k, post, config)
    d = 1/R_t(X,k,post,config) * ( (X_t(X,k,config)-post(1))*dXddt(X,k,config) + (Y_t(X,k,config)-post(2))*dYddt(X,k,config) + (Z_t(X,k,config)-post(3))*dZddt(X,k,config) );
end



