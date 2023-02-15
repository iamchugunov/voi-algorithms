function dS = make_dS(y, X, posts)
    dS = zeros(length(y),length(X));
    for i = 1:length(y)
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2);
        dS(i,1) = (X(1,1) - posts(1,i))/d;
        dS(i,4) = (X(4,1) - posts(2,i))/d;
        dS(i,7) = (X(7,1) - posts(3,i))/d;
    end
end