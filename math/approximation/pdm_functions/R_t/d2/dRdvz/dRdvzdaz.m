function [d] = dRdvzdaz(X, k, post, config)
%     d = (Z_t(X,k,config)-post(3))/R_t(X,k,post,config)*dZdvz(X,k,config);
    s1 =(dZdaz(X,k,config)*R_t(X,k,post,config) - (Z_t(X,k,config) - post(3))*dRdaz(X,k,post,config))/R_t(X,k,post,config)^2 * dZdvz(X,k,config);
    s2 = (Z_t(X,k,config) - post(3))/R_t(X,k,post,config) * dZdd(X,k,config);
    d = s1 + s2;
end