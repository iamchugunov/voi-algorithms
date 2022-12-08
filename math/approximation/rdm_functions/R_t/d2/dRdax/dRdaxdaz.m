function [d] = dRdaxdaz(X, t, post)
%     d = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdax(X,t);
    s1 =(dXdaz(X,t)*R_t(X,t,post) - (X_t(X,t) - post(1))*dRdaz(X,t,post))/R_t(X,t,post)^2 * dXdax(X,t);
    s2 = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end