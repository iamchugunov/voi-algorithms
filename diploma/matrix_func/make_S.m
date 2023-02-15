function S = make_S(y, X, posts)
    S = zeros(length(y),1);
    for i = 1:length(y)
        S(i,1) = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2);
    end
end