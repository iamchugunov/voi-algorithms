function [KFilter] = RDKalmanFilter_Accumulation(track, config, s_ksi, X0, Dx0, params_disk)
    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(3) * s_ksi^2;
    Dx = Dx0;
    X_prev = [X0(1); X0(2); 0; X0(3); X0(4); 0; X0(5); X0(6);0];
    T = params_disk.T;
    T_nak = params_disk.T_nak;

    t = [];
  
    t_res_last = poits(1).Frame;
    k = 0;
    for i = 1:length(poits)
        if poits(i).Frame - t_res_last > T
            k = k + 1;
            t_res_last = poits(i).Frame;
            current_poits = poits(i);
            k1 = 0;
            for j = 1:i
                if poits(i).Frame - poits(j).Frame < T_nak
                    k1 = k1 + 1;
                    current_poits(k1) = poits(j);
                end
            end
            t(k) = t_res_last;
            [X, Dx, d] = RDKalmanFilter_Accumulation_Calc(current_poits, X_prev, Dx, s_n, D_ksi, config, T);
            
            
        end
    end

    KFilter.X = X;
    KFilter.crd = X([1 4 7],:);
    KFilter.vel = X([2 5 8],:);
    KFilter.acc = X([3 6 9],:);
    KFilter.Dx = Dx;
    KFilter.discr = d;
end