function [d] = dRddtdvx(X, k, post, config)
%     d = 1/R_t(X,k,post,config) * ( (X_t(X,k,config)-post(1))*dXddt(X,k,config) + (Y_t(X,k,config)-post(2))*dYddt(X,k,config) + (Z_t(X,k,config)-post(3))*dZddt(X,k,config) );
    s1 =(dXdvx(X,k,config)*R_t(X,k,post,config) - (X_t(X,k,config) - post(1))*dRdvx(X,k,post,config))/R_t(X,k,post,config)^2 * dXddt(X,k,config);
    s2 = (X_t(X,k,config) - post(1))/R_t(X,k,post,config) * dXddtdvx(X,k,config);

    d = s1 + s2;
end