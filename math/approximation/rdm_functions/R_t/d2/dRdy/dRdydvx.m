function [d] = dRdydvx(X, t, post)
%     d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dYdy(X,t);
    s1 =(dYdvx(X,t)*R_t(X,t,post) - (Y_t(X,t) - post(2))*dRdvx(X,t,post))/R_t(X,t,post)^2 * dYdy(X,t);
    s2 = (Y_t(X,t) - post(2))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end