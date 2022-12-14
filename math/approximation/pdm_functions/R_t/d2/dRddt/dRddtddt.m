function [d] = dRddtddt(X, k, post, config)
%     d = 1/R_t(X,k,post,config) * ( (X_t(X,k,config)-post(1))*dXddt(X,k,config) + (Y_t(X,k,config)-post(2))*dYddt(X,k,config) + (Z_t(X,k,config)-post(3))*dZddt(X,k,config) );
    s1 =(dXddt(X,k,config)*R_t(X,k,post,config) - (X_t(X,k,config) - post(1))*dRddt(X,k,post,config))/R_t(X,k,post,config)^2 * dXddt(X,k,config);
    s2 = (X_t(X,k,config) - post(1))/R_t(X,k,post,config) * dXddtddt(X,k,config);
    
    s3 =(dYddt(X,k,config)*R_t(X,k,post,config) - (Y_t(X,k,config) - post(2))*dRddt(X,k,post,config))/R_t(X,k,post,config)^2 * dYddt(X,k,config);
    s4 = (Y_t(X,k,config) - post(2))/R_t(X,k,post,config) * dYddtddt(X,k,config);
    
    s5 =(dZddt(X,k,config)*R_t(X,k,post,config) - (Z_t(X,k,config) - post(3))*dRddt(X,k,post,config))/R_t(X,k,post,config)^2 * dZddt(X,k,config);
    s6 = (Z_t(X,k,config) - post(3))/R_t(X,k,post,config) * dZddtddt(X,k,config);
    d = s1 + s2 + s3 + s4 + s5 + s6;
end