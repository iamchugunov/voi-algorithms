function [KFilter] = RDKalmanFilter3D_group(track, config, X0, Dx0, s_ksi)
    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(3) * s_ksi^2;
    X_prev = [X0(1); X0(2); 0; X0(3); X0(4); 0; X0(5); X0(6);0];
    Dx = Dx0;
    Dx_hist(:,1) = diag(Dx);
    X = X_prev;
    for i = 2:length(poits)
        dt = poits(i).Frame - poits(i-1).Frame;
        [X(:,i), Dx, discr] = Kalman_step_3Drd(poits(i).ToA*config.c_ns, X(:,i-1), Dx, dt, s_n, D_ksi, config); 
        Dx_hist(:,i) = diag(Dx);
        d(:,i) = discr;
    end
    KFilter.t = [poits.Frame];
    KFilter.X = X;
    KFilter.crd = X([1 4 7],:);
    KFilter.vel = X([2 5 8],:);
    KFilter.acc = X([3 6 9],:);
    KFilter.Dx = Dx_hist;
    KFilter.Dx_last = Dx;
    KFilter.discr = d;
end