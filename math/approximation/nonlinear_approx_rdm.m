function [] = nonlinear_approx_rdm(poits, config, order)
    t = [poits.Frame];
    t0 = t(1);
    t = t - t0;
    
    eps = 0.00001;
    iter_max = 10;
    iter = 0;
    while 1
        dpdX = zeros(3*order, 1);
        dp2d2X = zeros(3*order, 3*order);
        for i = 1:length(t)
            toa = poits(i).ToA * config.c_ns;
            nms = find(toa > 0);
            toa = toa(nms);
            posts = config.posts(:,nms);
            [d, dd] = get_deriv_rdm(X, t(i), toa, posts, order);
            dpdX = dpdX + d;
            dp2d2X = dp2d2X + dd;
        end
        X_prev = X;
        X = X - inv(dp2d2X) * dpdX;
        iter = iter + 1;
        if norm(X - X_prev) < eps || iter > iter_max
            R = dp2d2X;
            D = inv(-R);
            R = sqrt(abs(D));
            break;
        end
    end
end

