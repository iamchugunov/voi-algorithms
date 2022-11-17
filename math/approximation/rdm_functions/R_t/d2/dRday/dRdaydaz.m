function [d] = dRdaydaz(X, t, post)
%     d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dXday(X,t);
    s1 =(dXdaz(X,t)*R_t(X,t,post) - (Y_t(X,t) - post(2))*dRdaz(X,t,post))/R_t(X,t,post)^2 * dXday(X,t);
    s2 = (Y_t(X,t) - post(2))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end