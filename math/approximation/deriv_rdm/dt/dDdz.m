function [dD] = dDdz(X, t, post1, post2, order, prm)
    dD = dRdz(X, t, post1, order, prm) - dRdz(X, t, post2, order, prm);
end



