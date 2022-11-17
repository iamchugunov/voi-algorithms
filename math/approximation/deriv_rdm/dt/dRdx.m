function [dR] = dRdx(X, t, post, order, prm)
    dR = (X_t(X, t, order) - post(1))/R_t(X, t, post, order)*dXdx(prm);
end

