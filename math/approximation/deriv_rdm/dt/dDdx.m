function [dD] = dDdx(X, t, post1, post2, order, prm)
    dD = dRdx(X, t, post1, order, prm) - dRdx(X, t, post2, order, prm);
end

