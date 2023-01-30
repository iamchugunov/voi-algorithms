function [] = show_primary_points2D(poits)
    X = zeros(3,length(poits));
    t = zeros(length(poits));
    k = 0;
    for i = 1:length(poits)
        if poits(i).crd_valid
            k = k + 1;
            X(:,k) = poits(i).est_crd;
            t(k) = poits(i).Frame;
        end
    end
    X = X(:,1:k);
    t = t(1:k);
    plot(X(1,:)/1000,X(2,:)/1000,'xr')
end

