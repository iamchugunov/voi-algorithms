function [X, R] = nonlinear_approx_rdm1(poits, config, X)
    t = [poits.Frame];
    t0 = t(1);
    t = t - t0;
    
    eps = 0.001;
    iter_max = 10;
    iter = 0;
    
    
    while 1
        dpdX = zeros(6, 1);
        dp2d2X = zeros(6, 6);
        x.x = X(1,1);
        x.vx = X(2,1);
        x.ax = 0;
        x.y = X(3,1);
        x.vy = X(4,1);
        x.ay = 0;
        x.z = X(5,1);
        x.vz = X(6,1);
        x.az = 0;
        for i = 1:length(t)
            toa = poits(i).ToA * config.c_ns;
            nms = find(toa > 0);
            toa = toa(nms);% + (poits(i).Frame - t0)*config.c_ns;
            posts = config.posts(:,nms);
            [d, dd] = get_deriv_rdm1(x, t(i), toa, posts);
            dpdX = dpdX + d;
            dp2d2X = dp2d2X + dd;
        end
        dpdX = dpdX / (config.sigma_n_ns * config.c_ns)^2;
        dp2d2X = dp2d2X / (config.sigma_n_ns * config.c_ns)^2;
        X_prev = X;
        X = X - inv(dp2d2X) * dpdX;
        iter = iter + 1;
        [norm(X - X_prev) iter]
        if norm(X - X_prev) < eps || iter > iter_max
            R = dp2d2X;
            D = inv(-R);
            R = diag(sqrt(abs(D)));
            break;
        end
    end
end

