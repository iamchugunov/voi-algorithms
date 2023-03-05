%% track
clear all
close all
config = Config();
traj_params.X0 = [50e3; -50e3]; 
traj_params.V = 200; 
traj_params.kurs = 135; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 600]; 

traj_params.track_id = 0;

% traj_params.maneurs(1) = struct('t0',100,'t',200,'acc',0,'omega',1);
% traj_params.maneurs(2) = struct('t0',300,'t',400,'acc',0,'omega',-1);
% traj_params.maneurs(3) = struct('t0',500,'t',600,'acc',1,'omega',0);
% 
% traj_params.maneurs(1) = struct('t0',1,'t',600,'acc',0,'omega',0.6);
traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
%% thinning track
% params.mode = 0;
% params.percentage = [0.4 0.4 0.2];
% params.banned_post = 2;
% [track.poits, res] = thinning_measurements(track.poits, params, config);
%% setting the algorithm parameters
paramsT.T_nak = 5;
paramsT.T = 5;
s_ksi = 100;
sigma_Dx0 = 1;
nms = find([track.t] < paramsT.T);
Order = 9; % 3 - X Y Z
           % 6 - X Vx Y Vy Z Vz
           % 9 - X Vx ax Y Vy ay Z Vz az

switch Order
    case 9
        X0 = [track.crd(1,nms(end));track.vel(1,nms(end));track.acc(1,nms(end));
          track.crd(2,nms(end));track.vel(2,nms(end));track.acc(2,nms(end));
          track.crd(3,nms(end));track.vel(3,nms(end));track.acc(3,nms(end));];
        Dx0 = sigma_Dx0*eye(9,9);
    case 6
        X0 = [track.crd(1,nms(end));track.vel(1,nms(end));
          track.crd(2,nms(end));track.vel(2,nms(end));
          track.crd(3,nms(end));track.vel(3,nms(end));];
        Dx0 = sigma_Dx0*eye(6,6);
    case 3
        X0 = [track.crd(1,nms(end));
          track.crd(2,nms(end));
          track.crd(3,nms(end));];
        Dx0 = sigma_Dx0*eye(3,3);
end
%first - our EKF with accumulation poits
%second - simple EKF without accumulation poits
Filter = RDKalmanFilter3D_Accum(track, config, s_ksi, X0, Dx0, paramsT);

X01 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
KFilter = RDKalmanFilter3D(track, config, X01, Dx0, s_ksi);

X_true = RDKalman_True_Value_Ext(track, Filter.t);
err_RD = Filter.X - X_true;
err_crd_RD = err_RD([1 4 7],:);
err_vel_RD = err_RD([2 5 8],:);
err_acc_RD = err_RD([3 6 9],:);

err_crd_RDK = KFilter.crd - [track.poits.true_crd];
err_vel_RDK = KFilter.vel - [track.poits.true_vel];
err_acc_RDK = KFilter.acc - [track.poits.true_acc];


%% any graphics
show_posts2D
show_track2D(track)
hold on
plot(Filter.crd(1,:)/1000,Filter.crd(2,:)/1000, "r-")
hold on
plot(KFilter.crd(1,:)/1000,KFilter.crd(2,:)/1000, "b.-")
xlabel('x, km')
ylabel('y, km')
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend("posts","model","EKF with accum","simple EKF")
% figure
% plot(track.t,track.crd(3,:)/1000)
% hold on
% plot(Filter.t,Filter.crd(3,:)/1000)
% figure
% plot(track.t, track.crd(1,:)/1000 )
% hold on
% plot(Filter.t, Filter.crd(1,:)/1000)

for i = 1:length(err_crd_RD)
    norm_err_crd_RD(i) = norm(err_crd_RD([1 2 3],i));
end
for i = 1:length(err_crd_RDK)
    norm_err_crd_RDK(i) = norm(err_crd_RDK([1 2 3],i));
end

figure
plot(Filter.t, norm_err_crd_RD, "r-")
grid on
grid minor
hold on
plot(KFilter.t, norm_err_crd_RDK, "b-")
% plot(KFilter.t, err_crd_RDK([1 2 3],:), "b-") %[1 2 3]
plot(Filter.t,3*sqrt(Filter.Dx_hist(1,:)), "k.-")
% hold on
% plot(Filter.t,-3*sqrt(Filter.Dx_hist(1,:)), "k.-")
xlabel('t, sec')
ylabel('errCrd, m')
legend("EKF with accum","simple EKF","3*sqrt(Dx)")

figure
plot(Filter.t, Filter.Dx_hist, "r-")
grid on
grid minor
hold on
plot(KFilter.t, KFilter.Dx, "b-") %[1 2 3]

