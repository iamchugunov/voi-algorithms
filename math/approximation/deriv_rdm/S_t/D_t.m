function [D] = D_t(X, t, post1, post2, order)
    D = R_t(X, t, post1, order) - R_t(X, t, post2, order);
end

