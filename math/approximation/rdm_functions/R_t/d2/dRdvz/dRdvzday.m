function [d] = dRdvzday(X, t, post)
%     d = (Z_t(X,t) - post(3))/R_t(X,t,post) * dZdvz(X,t);
    s1 =(dZday(X,t)*R_t(X,t,post) - (Z_t(X,t) - post(3))*dRday(X,t,post))/R_t(X,t,post)^2 * dZdvz(X,t);
    s2 = (Z_t(X,t) - post(3))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end