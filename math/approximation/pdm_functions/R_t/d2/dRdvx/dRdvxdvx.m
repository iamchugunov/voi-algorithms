function [d] = dRdvxdvx(X, k, post, config)
%     d = (X_t(X,k,config)-post(1))/R_t(X,k,post,config)*dXdvx(X,k,config);
    s1 =(dXdvx(X,k,config)*R_t(X,k,post,config) - (X_t(X,k,config) - post(1))*dRdvx(X,k,post,config))/R_t(X,k,post,config)^2 * dXdvx(X,k,config);
    s2 = (X_t(X,k,config) - post(1))/R_t(X,k,post,config) * dXdd(X,k,config);
    d = s1 + s2;
end