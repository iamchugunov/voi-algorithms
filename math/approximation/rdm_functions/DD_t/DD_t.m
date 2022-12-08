function [D] = DD_t(X, t, post1, post2, post3)
    D = D_t(X,t,post1,post2) * D_t(X,t,post1,post3);
end

