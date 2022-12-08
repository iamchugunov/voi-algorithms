function [d] = dRdydy(X, t, post)
%     d = (Y_t(X,t) - post(2))/R_t(X,t,post) * dYdy(X,t);
    s1 =(dYdy(X,t)*R_t(X,t,post) - (Y_t(X,t) - post(2))*dRdy(X,t,post))/R_t(X,t,post)^2 * dYdy(X,t);
    s2 = (Y_t(X,t) - post(2))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end