clear all
close all
config = Config();
traj_params.X0 = [150e3; -150e3];
traj_params.V = 200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [0 3600];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',1200,'t',2000,'acc',0,'omega',0.3);
% traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
% traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);

config.sigma_n_ns = 30;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.012;
measurements_params.s_ksi = 1e-8*0;
track = make_measurements_for_track(track, measurements_params, config);
show_posts3D
show_track3D(track)
% daspect([1 1 1])
%%
poits = track.poits;
params.mode = 1;
params.percentage = [0 100 0];
params.banned_post = 4;
[poits, res] = thinning_measurements(poits, params, config);
X = [];
X4 = [];
k = 0;
for i = 1:length(poits)
    poits(i) = crd_calc_h(poits(i),config,poits(i).true_crd);
%     poits(i) = crd_calc_h(poits(i),config,[0;0;10000]);
    if poits(i).crd_valid
        k = k + 1;
        t4(k) = poits(i).Frame;
        X4(:,k) = poits(i).est_crd - poits(i).true_crd;
    end
end
show_primary_points3D(poits)
% for i = 1:length(poits)
%     poits(i) = crd_calc(poits(i),config);
%     X1(:,i) = poits(i).est_crd - poits(i).true_crd;
% end
% show_primary_points3D(poits)
%%
poits = track.poits;
params.mode = 1;
params.percentage = [0 100 0];
params.banned_post = 4;
% [poits, res] = thinning_measurements(poits, params, config);
track.poits = poits;
sigma_ksi = 10;
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  Dx0 = eye(6);
  h_geo = 8000;
[KFilter1] = RDKalmanFilter2D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo);
sigma_h = 10000;
X0 = [track.poits(1).true_crd(1,1);
    track.poits(1).true_vel(1,1);
    track.poits(1).true_crd(2,1);
    track.poits(1).true_vel(2,1);
    track.poits(1).true_crd(3,1);
    track.poits(1).true_vel(3,1);];
Dx0 = eye(9);
h_geo = 10000;
[KFilter2] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);
show_posts2D
show_track2D(track)
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'.-')
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'.-')