function [res] = nonlinear_approx_pdm_T(poits, config, X, T)
    addpath(genpath('D:\Projects\voi-algorithms\math\approximation\pdm_functions'))
    t = [poits.Frame];
    t0 = t(1);
    t = t - t0;
    
    y = zeros(4,length(t));
    for i = 1:length(poits)
        for j = 1:4
            if poits(i).ToA(j) > 0
                y(j,i) = (poits(i).Frame - t0)*config.c + poits(i).ToA(j)*config.c_ns; 
            end
        end
    end
    
    eps = 0.001;
    iter_max = 20;
    iter = 0;
    
    
    res = [];
    
%     T = X(end);
%     X = X(1:end-1);
    N = length(X);
    while 1
        dpdX = zeros(N, 1);
        dp2d2X = zeros(N, N);
        switch N
            case 4
                x.x = X(1,1);
                x.vx = 0;
                x.ax = 0;
                x.y = X(2,1);
                x.vy = 0;
                x.ay = 0;
                x.z = X(3,1);
                x.vz = 0;
                x.az = 0;
                x.T = X(4,1);
                x.dt = T * config.c;
            case 7
                x.x = X(1,1);
                x.vx = X(2,1);
                x.ax = 0;
                x.y = X(3,1);
                x.vy = X(4,1);
                x.ay = 0;
                x.z = X(5,1);
                x.vz = X(6,1);
                x.az = 0;
                x.T = X(7,1);
                x.dt = T * config.c;
            case 10
                x.x = X(1,1);
                x.vx = X(2,1);
                x.ax = X(3,1);
                x.y = X(4,1);
                x.vy = X(5,1);
                x.ay = X(6,1);
                x.z = X(7,1);
                x.vz = X(8,1);
                x.az = X(9,1);
                x.T = X(10,1);
                x.dt = T * config.c;
        end
        
        for i = 1:length(t)
            
            switch N
                case 4
                    [d, dd] = get_deriv_pdm_T0(x, i, y(:,i), config.posts, config);
                case 7
                    [d, dd] = get_deriv_pdm_T1(x, i, y(:,i), config.posts, config);
                case 10
                    [d, dd] = get_deriv_pdm_T2(x, t(i), toa, posts);
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
%         if norm(X - X_prev) < eps || iter > iter_max
        if norm(X - X_prev) < eps || iter > iter_max    
            R = dp2d2X;
            D = inv(-R);
            R = diag(sqrt(abs(D)));
            X(end) = X(end)/config.c;
            res.X = X;
            res.dp2d2X = dp2d2X;
            res.R = R;
            break;
        end
    end
    rmpath(genpath('D:\Projects\voi-algorithms\math\approximation\pdm_functions'))
end

