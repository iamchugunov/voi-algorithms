function [d] = dRdazdaz(X, t, post)
%     d = (Z_t(X,t) - post(3))/R_t(X,t,post) * dXdaz(X,t);
    s1 =(dXdaz(X,t)*R_t(X,t,post) - (Z_t(X,t) - post(3))*dRdaz(X,t,post))/R_t(X,t,post)^2 * dXdaz(X,t);
    s2 = (Z_t(X,t) - post(3))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end