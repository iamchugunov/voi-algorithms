function [d] = dRdayday(X, t, post)
%     d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dXday(X,t);
    s1 =(dXday(X,t)*R_t(X,t,post) - (Y_t(X,t) - post(2))*dRday(X,t,post))/R_t(X,t,post)^2 * dXday(X,t);
    s2 = (Y_t(X,t) - post(2))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end