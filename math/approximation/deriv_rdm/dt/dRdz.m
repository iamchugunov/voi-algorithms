function [dR] = dRdz(X, t, post, order, prm)
    dR = (Z_t(X, t, order) - post(3))/R_t(X, t, post, order)*dXdz(prm);
end



