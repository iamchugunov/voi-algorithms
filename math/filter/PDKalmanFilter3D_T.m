function [KFilter] = PDKalmanFilter3D_T(track, config, X0, s_ksi, T)
    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(3) * s_ksi^2;
    X_prev = [X0(1); X0(2); 0; X0(3); X0(4); 0; X0(5); X0(6);0; X0(7)*config.c];
    Dx = eye(10);
    Dx_hist(:,1) = diag(Dx);
    X = X_prev;
    for i = 2:length(poits)
%         dt = poits(i).true_ToT - poits(i-1).true_ToT;
        dt = T;
        nms = find(poits(i).ToA == 0);
        y = poits(i).ToA*config.c_ns + poits(i).Frame * config.c;
        y(nms) = 0;
        [X(:,i), Dx, discr] = Kalman_step_3Dpd_T(y, X(:,i-1), Dx, dt, s_n, D_ksi, config); 
        Dx_hist(:,i) = diag(Dx);
        d(:,i) = discr;
    end
    KFilter.t = [poits.Frame];
    KFilter.X = X;
    KFilter.Dx = Dx_hist;
    KFilter.Dx_last = Dx;
    X_true = [];
    X_true([1 4 7],:) = [track.poits.true_crd];
    X_true([2 5 8],:) = [track.poits.true_vel];
    X_true([3 6 9],:) = 0;
    X_true(10,:) = [track.poits.true_ToT] * config.c;
    KFilter.err = X - X_true;
    KFilter.discr = d;
end



