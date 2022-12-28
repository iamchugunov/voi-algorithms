function [d] = dRdxdy(X, k, post, config)
%     d = (X_t(X,k,config)-post(1))/R_t(X,k,post,config)*dXdx(X,k,config);
    s1 =(dXdy(X,k,config)*R_t(X,k,post,config) - (X_t(X,k,config) - post(1))*dRdy(X,k,post,config))/R_t(X,k,post,config)^2 * dXdx(X,k,config);
    s2 = (X_t(X,k,config) - post(1))/R_t(X,k,post,config) * dXdd(X,k,config);
    d = s1 + s2;
end