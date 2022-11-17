function [x] = X_t(X, t, order)
    cnt = order + 1;
    n1 = 1;
    n2 = n1 + order;
    koefs = X(n1:n2);
    x = 0;
    for i = 1:cnt
        x = x + koefs(i)*t^(i-1);
    end
end

