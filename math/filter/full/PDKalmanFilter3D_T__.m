function [KFilter] = PDKalmanFilter3D_T__(track, config, X0, Dx, s_ksi, T, s_ksi_T)
    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(3) * s_ksi^2;
    D_ksi(4,4) = s_ksi_T^2;
    X_prev = [X0(1); X0(2); 0; X0(3); X0(4); 0; X0(5); X0(6);0; X0(7)*config.c; X0(8)];
%     Dx = eye(10);
    Dx_hist(:,1) = diag(Dx);
    X = X_prev;
    for i = 2:length(poits)
%         dt = poits(i).true_ToT - poits(i-1).true_ToT;
        dt = T;
        nms = find(poits(i).ToA == 0);
        y = poits(i).ToA*config.c_ns + poits(i).Frame * config.c;
        y(nms) = 0;
        [X(:,i), Dx, discr] = Kalman_step_3Dpd_T__(y, X(:,i-1), Dx, dt, s_n, D_ksi, config); 
        Dx_hist(:,i) = diag(Dx);
%         d(:,i) = discr;
    end
    KFilter.t = [poits.Frame];
    KFilter.X = X;
    KFilter.crd = X([1 4 7],:);
    KFilter.vel = X([2 5 8],:);
    KFilter.acc = X([3 6 9],:);
    KFilter.ToT = X(10,:);
    KFilter.Dx = Dx_hist;
    KFilter.Dx_last = Dx;
%     KFilter.discr = d;
end



