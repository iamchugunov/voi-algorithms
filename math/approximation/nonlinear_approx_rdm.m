function [res] = nonlinear_approx_rdm(poits, config, X)
    addpath(genpath('D:\Projects\voi-algorithms\math\approximation\rdm_functions'))
    t = [poits.Frame];
    t0 = t(1);
    t = t - t0;

    eps = 0.001;
    iter_max = 20;
    iter = 0;

    N = length(X);
    res = [];

    while 1
        dpdX = zeros(N, 1);
        dp2d2X = zeros(N, N);
        switch N
            case 3
                x.x = X(1,1);
                x.vx = 0;
                x.ax = 0;
                x.y = X(2,1);
                x.vy = 0;
                x.ay = 0;
                x.z = X(3,1);
                x.vz = 0;
                x.az = 0;
            case 6
                x.x = X(1,1);
                x.vx = X(2,1);
                x.ax = 0;
                x.y = X(3,1);
                x.vy = X(4,1);
                x.ay = 0;
                x.z = X(5,1);
                x.vz = X(6,1);
                x.az = 0;
            case 9
                x.x = X(1,1);
                x.vx = X(2,1);
                x.ax = X(3,1);
                x.y = X(4,1);
                x.vy = X(5,1);
                x.ay = X(6,1);
                x.z = X(7,1);
                x.vz = X(8,1);
                x.az = X(9,1);
        end

        for i = 1:length(t)
            toa = poits(i).ToA * config.c_ns;
            nms = find(toa > 0);
            toa = toa(nms);% + (poits(i).Frame - t0)*config.c_ns;
            posts = config.posts(:,nms);
            switch N
                case 3
                    [d, dd] = get_deriv_rdm0(x, t(i), toa, posts);
                case 6
                    [d, dd] = get_deriv_rdm1(x, t(i), toa, posts);
                case 9
                    [d, dd] = get_deriv_rdm2(x, t(i), toa, posts);
            end
            dpdX = dpdX + d;
            dp2d2X = dp2d2X + dd;
        end
        dpdX = dpdX / (config.sigma_n_ns * config.c_ns)^2;
        dp2d2X = dp2d2X / (config.sigma_n_ns * config.c_ns)^2;
        X_prev = X;
        X = X - inv(dp2d2X) * dpdX;
        iter = iter + 1;
        res.nev(:,iter) = X - X_prev;
        res.iter = iter;
        res.X_hist(:,iter) = X;
        res.norm_nev(iter) = norm(X - X_prev);
                [norm(X - X_prev) iter]
        if norm(X - X_prev) < eps || iter > iter_max || (iter > 2 && norm(X - X_prev) > 1e6)
            R = dp2d2X;
            D = inv(-R);
            R = diag(sqrt(D));
            res.X = X;
            res.dp2d2X = dp2d2X;
            res.R = R;

            SV = [9,length(t)];
            switch N
                case 3
                    SV(1,1) = X(1,1);
                    SV(2,1) = 0;
                    SV(3,1) = 0;
                    SV(4,1) = X(2,1);
                    SV(5,1) = 0;
                    SV(6,1) = 0;
                    SV(7,1) = X(3,1);
                    SV(8,1) = 0;
                    SV(9,1) = 0;
                case 6
                    SV(1,1) = X(1,1);
                    SV(2,1) = X(2,1);
                    SV(3,1) = 0;
                    SV(4,1) = X(3,1);
                    SV(5,1) = X(4,1);
                    SV(6,1) = 0;
                    SV(7,1) = X(5,1);
                    SV(8,1) = X(6,1);
                    SV(9,1) = 0;
                case 9
                    SV(1,1) = X(1,1);
                    SV(2,1) = X(2,1);
                    SV(3,1) = X(3,1);
                    SV(4,1) = X(4,1);
                    SV(5,1) = X(5,1);
                    SV(6,1) = X(6,1);
                    SV(7,1) = X(7,1);
                    SV(8,1) = X(8,1);
                    SV(9,1) = X(9,1);
            end
            t = t(1):t(end);
            for i = 2:length(t)
                dt = t(i) - t(i-1);
                F1 = [1 dt dt^2/2;
                      0 1 dt;
                      0 0 1];
                F0 = zeros(3,3);
                F = [F1 F0 F0; F0 F1 F0; F0 F0 F1];
                SV(:,i) = F * SV(:,i-1);
            end
            
            res.t = [poits.Frame];
            res.crd = SV([1 4 7],:);
            res.vel = SV([2 5 8],:);
            res.acc = SV([3 6 9],:);
            break;
        end
    end
    rmpath(genpath('D:\Projects\voi-algorithms\math\approximation\rdm_functions'))
end

