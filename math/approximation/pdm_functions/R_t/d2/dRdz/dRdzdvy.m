function [d] = dRdzdvy(X, k, post, config)
%     d = (Z_t(X,k,config)-post(3))/R_t(X,k,post,config)*dZdz(X,k,config);
    s1 =(dZdvy(X,k,config)*R_t(X,k,post,config) - (Z_t(X,k,config) - post(3))*dRdvy(X,k,post,config))/R_t(X,k,post,config)^2 * dZdz(X,k,config);
    s2 = (Z_t(X,k,config) - post(3))/R_t(X,k,post,config) * dZdd(X,k,config);
    d = s1 + s2;
end