%%
close all
clear all
config = Config();
traj_params.X0 = [50e3; -50e3];
traj_params.V = 200*0;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [1 600];
traj_params.track_id = 0;
% traj_params.maneurs = [];
traj_params.maneurs(1) = struct('t0',200,'t',300,'acc',0,'omega',1);
traj_params.maneurs(2) = struct('t0',400,'t',500,'acc',0,'omega',-1);
track = make_geo_track_new(traj_params, config);
config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
%%
X0 = [track.poits(1).true_crd(1,1);
    track.poits(1).true_vel(1,1);
    0;
    track.poits(1).true_crd(2,1);
    track.poits(1).true_vel(2,1);
    0;
    track.poits(1).true_crd(3,1);
    track.poits(1).true_vel(3,1);
    0];
% X0 = zeros(6,1);

res = nonlinear_approx_rdm(track.poits(1:300), config, X0);
[res.X res.R]
% Dx = inv(-res.dp2d2X);
% R = zeros(9,1);
% R([1 2 4 5 7 8]) = res.R.^2;
% Dx = R.* eye(9);
Dx = eye(9);
sigma_ksi = 0.1;
KFilter_res_rd = RDKalmanFilter3D(track, config, res.X([1 2 4 5 7 8]) , Dx, sigma_ksi);
[err] = err_calc(track, KFilter_res_rd,config);
%%
X0 = [track.poits(1).true_crd(1,1);
    track.poits(1).true_vel(1,1);
    0;
    track.poits(1).true_crd(2,1);
    track.poits(1).true_vel(2,1);
    0;
    track.poits(1).true_crd(3,1);
    track.poits(1).true_vel(3,1);
    0];
% X0 = zeros(6,1);

res = nonlinear_approx_rdm(track.poits(1:300), config, X0);
[res.X res.R]
% Dx = inv(-res.dp2d2X);
% R = zeros(9,1);
% R([1 2 4 5 7 8]) = res.R.^2;
% Dx = R.* eye(9);
Dx = eye(9);
sigma_ksi = 0.1:0.1:5;
R = [];
for i = 1:length(sigma_ksi)
    KFilter_res_rd = RDKalmanFilter3D(track, config, res.X([1 2 4 5 7 8]) , Dx, sigma_ksi(i));
    R(:,i) = sqrt(KFilter_res_rd.Dx(:,end));
end
figure
for i = 1:9
    subplot(9,1,i)
    plot(sigma_ksi,R(i,:))
    hold on
    plot(sigma_ksi,ones(1,length(sigma_ksi))*res.R(i))
end