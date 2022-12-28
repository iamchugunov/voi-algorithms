function [d] = dRddtdvz(X, k, post, config)
%     d = 1/R_t(X,k,post,config) * ( (X_t(X,k,config)-post(1))*dXddt(X,k,config) + (Y_t(X,k,config)-post(2))*dYddt(X,k,config) + (Z_t(X,k,config)-post(3))*dZddt(X,k,config) );
    s1 =(dXdvz(X,k,config)*R_t(X,k,post,config) - (Z_t(X,k,config) - post(3))*dRdvz(X,k,post,config))/R_t(X,k,post,config)^2 * dZddt(X,k,config);
    s2 = (Z_t(X,k,config) - post(3))/R_t(X,k,post,config) * dZddtdvz(X,k,config);

    d = s1 + s2;
end