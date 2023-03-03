clear all
close all
config = Config();
traj_params.X0 = [150e3; -150e3];
traj_params.V = 200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [0 3000];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',1200,'t',2000,'acc',0,'omega',0.3);
% traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
% traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);

config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.012;
measurements_params.s_ksi = 1e-8;
track = make_measurements_for_track(track, measurements_params, config);
show_posts3D
show_track3D(track)
% daspect([1 1 1])
%%
close all
poits = track.poits;
params.mode = 1;
params.percentage = [0 100 0];
params.banned_post = 3;
% [poits, res] = thinning_measurements(poits, params, config);
track.poits = poits;

sigma_ksi = 1;
h_geo = 10000;
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
  Dx0 = eye(10);
  
[KFilter1] = PDKalmanFilter3D_T(track, config, [X0;track.poits(1).true_ToT], Dx0, sigma_ksi, measurements_params.period_sec);
sigma_h = 0.1;
Dx0 = eye(9);
[KFilter2] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

Dx0 = eye(9);
[KFilter3] = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);
show_posts2D
show_track2D(track)
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'r.-')
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'g.-')
plot(KFilter3.crd(1,:)/1000,KFilter3.crd(2,:)/1000,'b.-')

  [err] = err_calc(track, KFilter1,config);
  [err] = err_calc(track, KFilter2,config);
  [err] = err_calc(track, KFilter3,config);
  
  err_comparison([KFilter1 KFilter2 KFilter3],{'PD', 'RDh', 'RD'})
%%
%%
close all
poits = track.poits;
params.mode = 1;
params.percentage = [0 100 0];
params.banned_post = 3;
% [poits, res] = thinning_measurements(poits, params, config);
track.poits = poits;

sigma_ksi = 10;
h_geo = 10000;
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  

sigma_h = 0.1;
Dx0 = eye(9);
[KFilter1] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

sigma_h = 1;
Dx0 = eye(9);
[KFilter2] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

sigma_h = 10;
Dx0 = eye(9);
[KFilter3] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

sigma_h = 100;
Dx0 = eye(9);
[KFilter4] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

sigma_h = 1000;
Dx0 = eye(9);
[KFilter5] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

sigma_h = 5000;
Dx0 = eye(9);
[KFilter6] = RDKalmanFilter3D_hgeo(track, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

Dx0 = eye(9);
[KFilter7] = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);

  [err] = err_calc(track, KFilter1,config);
  [err] = err_calc(track, KFilter2,config);
  [err] = err_calc(track, KFilter3,config);
  [err] = err_calc(track, KFilter4,config);
  [err] = err_calc(track, KFilter5,config);
  [err] = err_calc(track, KFilter6,config);
  [err] = err_calc(track, KFilter7,config);
  err_comparison([KFilter1 KFilter2 KFilter3 KFilter4 KFilter5 KFilter6 KFilter7],{'0.1', '1', '10', '100', '1000', '5000','3D'})
  %% reallog iran
  [config] = Config('iran22');
  k = 0;
  X = [];
  for i = 1:length(trace.poits)
      if (trace.poits(i).count == 4)
          poit = crd_calc(trace.poits(i),config);
          if poit.crd_valid
              k = k + 1;
              X(:,k) = poit.est_crd;
          end
      end
  end
  
  
h_geo = 2000;
  X0 = [X(1,1); 
      0; 
      X(2,1); 
      0; 
      2000; 
      0;];
  
Dx0 = eye(9);

sigma_ksi = 0.1;
sigma_h = 10;
[KFilter1] = RDKalmanFilter3D_hgeo(trace, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

sigma_ksi = 0.1;
sigma_h = 100;
[KFilter2] = RDKalmanFilter3D_hgeo(trace, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

sigma_ksi = 0.1;
sigma_h = 5000;
[KFilter3] = RDKalmanFilter3D_hgeo(trace, config, X0, Dx0, sigma_ksi, h_geo, sigma_h);

show_posts2D
hold on
plot(X(1,:)/1000,X(2,:)/1000,'xy')
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'r.-')
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'g.-')
plot(KFilter3.crd(1,:)/1000,KFilter3.crd(2,:)/1000,'b.-')

plot(trace.modes(8,:)/1000,trace.modes(9,:)/1000,'k.-')
%%
%%
close all
poits = track.poits;

sigma_ksi = 1;

  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
  Dx0 = eye(10);
  
[KFilter1] = PDKalmanFilter3D_T(track, config, [X0;track.poits(1).true_ToT], Dx0, sigma_ksi, measurements_params.period_sec);
sigma_h = 0.1;
Dx0 = eye(10);
[KFilter2] = PDKalmanFilter3D_T_(track, config, [X0;track.poits(1).true_ToT], Dx0, sigma_ksi, measurements_params.period_sec, 100);

Dx0 = eye(11);
[KFilter3] = PDKalmanFilter3D_T__(track, config, [X0;track.poits(1).true_ToT;0], Dx0, sigma_ksi, measurements_params.period_sec, 1e-8*config.c);

show_posts2D
show_track2D(track)
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'r.-')
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'g.-')
plot(KFilter3.crd(1,:)/1000,KFilter3.crd(2,:)/1000,'b.-')

  [err] = err_calc(track, KFilter1,config);
  [err] = err_calc(track, KFilter2,config);
  [err] = err_calc(track, KFilter3,config);
  
  err_comparison([KFilter1 KFilter2 KFilter3],{'PD', 'RDh', 'RD'})
  %% Graphic T 
config = Config();
traj_params.X0 = [150e3; -150e3];
traj_params.V = 200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [0 1000];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',1200,'t',2000,'acc',0,'omega',0.3);
% traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
% traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);

config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.012;
measurements_params.s_ksi = 1e-6;
track = make_measurements_for_track(track, measurements_params, config);
plot(diff([track.poits.true_ToT])*1000)
grid minor
set(gca,'FontSize',14)
set(gca,'FontName','Times')
hold on
measurements_params.s_ksi = 1e-7;
track = make_measurements_for_track(track, measurements_params, config);
plot(diff([track.poits.true_ToT])*1000)
measurements_params.s_ksi = 1e-8;
track = make_measurements_for_track(track, measurements_params, config);
plot(diff([track.poits.true_ToT])*1000)
legend('?_?=10^{-6} סוך','?_?=10^{-7} סוך','?_?=10^{-8} סוך')
xlabel('k')
ylabel('T^{״ֲׁ}, לס')