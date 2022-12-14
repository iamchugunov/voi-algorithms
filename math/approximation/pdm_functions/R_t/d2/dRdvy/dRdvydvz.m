function [d] = dRdvydvz(X, k, post, config)
%     d = (Y_t(X,k,config)-post(2))/R_t(X,k,post,config)*dYdvy(X,k,config);
    s1 =(dYdvz(X,k,config)*R_t(X,k,post,config) - (Y_t(X,k,config) - post(2))*dRdvz(X,k,post,config))/R_t(X,k,post,config)^2 * dYdvy(X,k,config);
    s2 = (Y_t(X,k,config) - post(2))/R_t(X,k,post,config) * dYdd(X,k,config);
    d = s1 + s2;
end