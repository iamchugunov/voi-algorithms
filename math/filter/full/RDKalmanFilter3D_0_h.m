function [KFilter] = RDKalmanFilter3D_0_h(track, config, X0, Dx0, s_ksi, h)
    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(2) * s_ksi^2;
    X_prev = [X0(1); X0(2)];
    Dx = Dx0;
    Dx_hist(:,1) = diag(Dx);
    X = X_prev;
    for i = 2:length(poits)
        dt = poits(i).Frame - poits(i-1).Frame;
%         dt = poits(i).true_ToT - poits(i-1).true_ToT;
        [X(:,i), Dx, discr] = Kalman_step_3Drd_0_h(poits(i).ToA*config.c_ns, X(:,i-1), Dx, dt, s_n, D_ksi, config, h); 
        Dx_hist(:,i) = diag(Dx);
        d(:,i) = discr;
    end
    KFilter.t = [poits.Frame];
    KFilter.X = X;
    KFilter.crd = [X; h*ones(1,length(KFilter.t))];
    KFilter.vel = zeros(3,length(KFilter.t));
    KFilter.acc = zeros(3,length(KFilter.t));
    KFilter.Dx = Dx_hist;
    KFilter.Dx_last = Dx;
    KFilter.discr = d;
end

