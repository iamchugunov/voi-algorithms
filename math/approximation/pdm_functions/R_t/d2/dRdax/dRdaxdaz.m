function [d] = dRdaxdaz(X, k, post, config)
%     d = (X_t(X,k,config)-post(1))/R_t(X,k,post,config)*dXdax(X,k,config);
    s1 =(dXdaz(X,k,config)*R_t(X,k,post,config) - (X_t(X,k,config) - post(1))*dRdaz(X,k,post,config))/R_t(X,k,post,config)^2 * dXdax(X,k,config);
    s2 = (X_t(X,k,config) - post(1))/R_t(X,k,post,config) * dXdd(X,k,config);
    d = s1 + s2;
end