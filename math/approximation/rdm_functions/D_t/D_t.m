function [D] = D_t(X, t, post1, post2)
    D = R_t(X,t,post1) - R_t(X,t,post2);
end

