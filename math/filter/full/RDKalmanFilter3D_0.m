function [KFilter] = RDKalmanFilter3D_0(track, config, X0, Dx0, s_ksi)
    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(3) * s_ksi^2;
    X_prev = [X0(1); X0(2); X0(3);];
    Dx = Dx0;
    Dx_hist(:,1) = diag(Dx);
    X = X_prev;
    for i = 2:length(poits)
        dt = poits(i).Frame - poits(i-1).Frame;
        [X(:,i), Dx, discr] = Kalman_step_3Drd_0(poits(i).ToA*config.c_ns, X(:,i-1), Dx, dt, s_n, D_ksi, config); 
        Dx_hist(:,i) = diag(Dx);
%         d(:,i) = discr;
    end
    KFilter.t = [poits.Frame];
    KFilter.X = X;
    KFilter.crd = X([1 2 3],:);
    KFilter.vel = zeros(3,length(KFilter.t));
    KFilter.acc = zeros(3,length(KFilter.t));
    KFilter.Dx = Dx_hist;
    KFilter.Dx_last = Dx;
%     KFilter.discr = d;
    KFilter.ToT = [];
end

