function [KFilter] = RDKalmanFilter3D_Accum_Full_Nak(track, config, s_ksi, ...
    X0, Dx0, params_disk)
    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(3,3) * s_ksi^2;
    Dx = Dx0;
    T = params_disk.T;
    T_nak = params_disk.T_nak;
    t = [];
    t_res_last = poits(1).Frame;
    k = 0;
    Dx_hist(:,1) = diag(Dx);
    switch length(X0)
        case 9
            X_prev = [X0(1); X0(2); X0(3);X0(4); X0(5); X0(6);X0(7); X0(8); X0(9);];
        case 6
            X_prev = [X0(1); X0(2); X0(3);X0(4); X0(5); X0(6);];
        case 3
            X_prev = [X0(1); X0(2); X0(3);];
    end

    for i = 1:length(poits)
        if poits(i).Frame - t_res_last > T
            k = k + 1; 
            current_poits = poits(i);
            k1 = 0;
            for j = 1:i
                if poits(i).Frame - poits(j).Frame < T_nak 
                    k1 = k1 + 1;
                    current_poits(k1) = poits(j);
                end
            end
            dt = current_poits(end).Frame - t_res_last;
            switch length(X0)
                case 9
                    [X, Dx] = Kalman_step_3Drd_Accum9(current_poits, X_prev, Dx, s_n, D_ksi, config, dt); 
                case 6
                    [X, Dx] = Kalman_step_3Drd_Accum6(current_poits, X_prev, Dx, s_n, D_ksi, config, dt);
                case 3
                    [X, Dx] = Kalman_step_3Drd_Accum3(current_poits, X_prev, Dx, s_n, D_ksi, config, dt);
             end
             t_res_last = poits(i).Frame;
             t(k) = t_res_last;
             X_prev = X;
             Xnak(:,k) = X;
             Dx_hist(:,k) = diag(Dx);
        end
    end

    switch length(X0)
        case 9
            KFilter.X = Xnak;
            KFilter.crd = Xnak([1 4 7],:);
            KFilter.vel = Xnak([2 5 8],:);
            KFilter.acc = Xnak([3 6 9],:);
            KFilter.Dx = Dx;
            KFilter.Dx_hist = Dx_hist;
            KFilter.t = t;
        case 6
            KFilter.X = Xnak;
            KFilter.crd = Xnak([1 3 5],:);
            KFilter.vel = Xnak([2 4 6],:);
            KFilter.Dx = Dx;
            KFilter.Dx_hist = Dx_hist;
            KFilter.t = t;
        case 3
            KFilter.X = Xnak;
            KFilter.crd = Xnak([1 2 3],:);
            KFilter.Dx = Dx;
            KFilter.Dx_hist = Dx_hist;
            KFilter.t = t;
    end
    
end

