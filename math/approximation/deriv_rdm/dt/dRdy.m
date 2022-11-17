function [dR] = dRdy(X, t, post, order, prm)
    dR = (Y_t(X, t, order) - post(2))/R_t(X, t, post, order)*dXdy(prm);
end



