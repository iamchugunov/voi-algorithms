function [d] = dRdvydvy(X, t, post)
%     d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dYdvy(X,t);
    s1 =(dYdvy(X,t)*R_t(X,t,post) - (Y_t(X,t) - post(2))*dRdvy(X,t,post))/R_t(X,t,post)^2 * dYdvy(X,t);
    s2 = (Y_t(X,t) - post(2))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end