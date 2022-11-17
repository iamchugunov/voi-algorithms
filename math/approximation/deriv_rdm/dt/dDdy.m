function [dD] = dDdy(X, t, post1, post2, order, prm)
    dD = dRdy(X, t, post1, order, prm) - dRdy(X, t, post2, order, prm);
end



