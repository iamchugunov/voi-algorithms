function [d] = dRdxdaz(X, t, post)
%     d = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdx(X,t);
    s1 =(dXdaz(X,t)*R_t(X,t,post) - (X_t(X,t) - post(1))*dRdaz(X,t,post))/R_t(X,t,post)^2 * dXdx(X,t);
    s2 = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end



