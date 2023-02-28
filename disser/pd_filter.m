clear all
close all
config = Config();
traj_params.X0 = [150e3; -150e3]/3;
traj_params.V = 0*200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [0 3000];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',1200,'t',2000,'acc',0,'omega',0.3);
% traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
% traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);

show_posts3D
show_track3D(track)
%%
config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.012;
measurements_params.s_ksi = 1e-8*0;
track = make_measurements_for_track(track, measurements_params, config);
%%
measurements_params.s_ksi = 1e-8;
track = make_measurements_for_track(track, measurements_params, config);
%%
poits = track.poits;

sigma_ksi = 10;

  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
  Dx0 = eye(10);
  
[KFilter1] = PDKalmanFilter3D_T(track, config, [X0;track.poits(1).true_ToT], Dx0, sigma_ksi, measurements_params.period_sec);

Dx0 = eye(11);
[KFilter2] = PDKalmanFilter3D_T__(track, config, [X0;track.poits(1).true_ToT;0], Dx0, sigma_ksi, measurements_params.period_sec, measurements_params.s_ksi*config.c);

Dx0 = eye(11);
[KFilter3] = PDKalmanFilter3D_T_corr(track, config, [X0;track.poits(1).true_ToT;0], Dx0, sigma_ksi, measurements_params.period_sec, (1e-8+measurements_params.s_ksi)*config.c);

Dx0 = eye(9);
[KFilter4] = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);

show_posts2D
show_track2D(track)
plot(KFilter4.crd(1,:)/1000,KFilter4.crd(2,:)/1000,'y.-')
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'r.-')
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'g.-')
plot(KFilter3.crd(1,:)/1000,KFilter3.crd(2,:)/1000,'b.-')

  [err] = err_calc(track, KFilter1,config);
  [err] = err_calc(track, KFilter2,config);
  [err] = err_calc(track, KFilter3,config);
  [err] = err_calc(track, KFilter4,config);
  
  err_comparison([KFilter1 KFilter2 KFilter3],{'PD', 'RDh', 'RD'})