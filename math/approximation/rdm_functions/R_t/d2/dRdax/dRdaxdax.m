function [d] = dRdaxdax(X, t, post)
%     d = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdax(X,t);
    s1 =(dXdax(X,t)*R_t(X,t,post) - (X_t(X,t) - post(1))*dRdax(X,t,post))/R_t(X,t,post)^2 * dXdax(X,t);
    s2 = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end