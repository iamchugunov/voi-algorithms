function [y] = Y_t(X, t, order)
    cnt = order + 1;
    n1 = order + 2;
    n2 = n1 + order;
    koefs = X(n1:n2);
    y = 0;
    for i = 1:cnt
        y = y + koefs(i)*t^(i-1);
    end
end

