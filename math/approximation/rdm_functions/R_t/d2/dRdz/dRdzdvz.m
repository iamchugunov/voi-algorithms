function [d] = dRdzdvz(X, t, post)
%     d = (Z_t(X,t) - post(3))/R_t(X,t,post) * dZdz(X,t);
    s1 =(dZdvz(X,t)*R_t(X,t,post) - (Z_t(X,t) - post(3))*dRdvz(X,t,post))/R_t(X,t,post)^2 * dZdz(X,t);
    s2 = (Z_t(X,t) - post(3))/R_t(X,t,post) * dXdd(X,t);
    d = s1 + s2;
end