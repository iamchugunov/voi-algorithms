function [d] = dRdvxday(X, t, post)
%     d = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdvx(X,t);
    s1 =(dXday(X,t)*R_t(X,t,post) - (X_t(X,t) - post(1))*dRday(X,t,post))/R_t(X,t,post)^2 * dXdvx(X,t);
    s2 = (X_t(X,t) - post(1))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end

