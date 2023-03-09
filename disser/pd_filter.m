clear all
close all
config = Config();
traj_params.X0 = [150e3; -150e3]/3;
traj_params.V = 200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [0 1000];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',1200,'t',2000,'acc',0,'omega',0.3);
% traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);

show_posts3D
show_track3D(track)
%%
clear all
close all
config = Config();
traj_params.X0 = [60e3; -100e3];
traj_params.V = 200;
traj_params.kurs = 60;

traj_params.h = 10e3;
traj_params.time_interval = [0 1900];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',200,'t',350,'acc',0,'omega',0.6);
traj_params.maneurs(2) = struct('t0',600,'t',650,'acc',0,'omega',-0.5);
traj_params.maneurs(3) = struct('t0',750,'t',1300,'acc',0,'omega',0.6);
traj_params.maneurs(4) = struct('t0',1300,'t',1425,'acc',0,'omega',1.4);
track = make_geo_track_new(traj_params, config);

show_posts3D
show_track3D(track)
%%
config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.012;
measurements_params.s_ksi = 1e-8*0;
track = make_measurements_for_track(track, measurements_params, config);
%%
measurements_params.s_ksi = 1e-8;
track = make_measurements_for_track(track, measurements_params, config);
%%
traj_params.V = 0;
track = make_geo_track_new(traj_params, config);
%%
traj_params.V = 200;
track = make_geo_track_new(traj_params, config);
%%
close all
poits = track.poits;

sigma_ksi = 0.1;

  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
  Dx0 = eye(10);
  
[KFilter1] = PDKalmanFilter3D_T(track, config, [X0;track.poits(1).true_ToT], Dx0, sigma_ksi, measurements_params.period_sec);
Dx1 = KFilter1.Dx_last;
Dx0 = eye(11);
[KFilter2] = PDKalmanFilter3D_T_corr(track, config, [X0;track.poits(1).true_ToT;0], Dx0, sigma_ksi, measurements_params.period_sec, measurements_params.s_ksi*config.c);
Dx2 = KFilter2.Dx_last;
Dx0 = eye(9);
[KFilter3] = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);
Dx3 = KFilter3.Dx_last;
%%
close all
poits = track.poits;

sigma_ksi = 0.1;

  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
  Dx0 = eye(10);
  
[KFilter1] = PDKalmanFilter3D_T(track, config, [X0;track.poits(1).true_ToT], Dx1, sigma_ksi, measurements_params.period_sec);

Dx0 = eye(11);
[KFilter2] = PDKalmanFilter3D_T_corr(track, config, [X0;track.poits(1).true_ToT;0], Dx2, sigma_ksi, measurements_params.period_sec, measurements_params.s_ksi*config.c);

Dx0 = eye(9);
[KFilter3] = RDKalmanFilter3D(track, config, X0, Dx3, sigma_ksi);

Dx0 = eye(9);
[KFilter4] = RDKalmanFilter3Dd(track, config, X0, Dx0, sigma_ksi);

show_posts2D
show_track2D(track)
plot(KFilter3.crd(1,:)/1000,KFilter3.crd(2,:)/1000,'y.-')
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'r.-')
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'g.-')
plot(KFilter4.crd(1,:)/1000,KFilter4.crd(2,:)/1000,'k.-')

  [err] = err_calc_dist(track, KFilter1,config);
  [err] = err_calc_dist(track, KFilter2,config);
  [err] = err_calc_dist(track, KFilter3,config);
  [err] = err_calc_dist(track, KFilter4,config);
  
  err_comparison_d([KFilter3 KFilter1 KFilter2 ],{'T = 0', 'T = sigma_ksi', 'ÐÄÔ'})
  %%
%   s_ksi = [0; 1e-11; 1e-10; 1e-9; 1e-8; 1e-7;];
s_ksi = [0; 1e-12; 5e-12; 1e-11; 5e-11; 1e-10; 5e-10; 1e-9; 5e-9; 1e-8; 5e-8; 1e-7; 5e-7; 1e-6; 5e-6; 1e-5];
  sigma_ksi = 10;
  clearvars leg KFilter Dx
  for i = 1:length(s_ksi)
      measurements_params.s_ksi = s_ksi(i);
      track = make_measurements_for_track(track, measurements_params, config);
      
      X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
      Dx0 = eye(11);
      KFilter(i) = PDKalmanFilter3D_T_corr(track, config, [X0;track.poits(1).true_ToT;0], Dx0, sigma_ksi, measurements_params.period_sec, measurements_params.s_ksi*config.c);
      leg{i} = ['s = ' num2str(s_ksi(i))];
      Dx{i} = KFilter(i).Dx_last;
  end
  
  Dx0 = eye(9);

KFilter(length(s_ksi)+1) = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);
Dx{length(s_ksi)+1} = KFilter(length(s_ksi)+1).Dx_last;
KFilter(length(s_ksi)+2) = RDKalmanFilter3Dd(track, config, X0, Dx0, sigma_ksi);
Dx{length(s_ksi)+2} = KFilter(length(s_ksi)+2).Dx_last;
  
  for i = 1:length(s_ksi)
      measurements_params.s_ksi = s_ksi(i);
      track = make_measurements_for_track(track, measurements_params, config);
      
      X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
      Dx0 = eye(11);
      KFilter(i) = PDKalmanFilter3D_T_corr(track, config, [X0;track.poits(1).true_ToT;0], Dx{i}, sigma_ksi, measurements_params.period_sec, measurements_params.s_ksi*config.c);
      leg{i} = ['s = ' num2str(s_ksi(i))];
  end
  
  leg{length(s_ksi)+1} = 'ÐÄÔ';
  leg{length(s_ksi)+2} = 'ÄÔ';
 Dx0 = eye(9);
KFilter(length(s_ksi)+1) = RDKalmanFilter3D(track, config, X0, Dx{length(s_ksi)+1}, sigma_ksi);
KFilter(length(s_ksi)+2) = RDKalmanFilter3Dd(track, config, X0, Dx{length(s_ksi)+2}, sigma_ksi);
err_comparison_d_pd(track,KFilter,leg,config,s_ksi)
%%
s_ksi = [0; 1e-10; 1e-9; 1e-8;];
  sigma_ksi = 0.1;
  clearvars leg KFilter Dx
  for i = 1:length(s_ksi)
      measurements_params.s_ksi = s_ksi(i);
      track = make_measurements_for_track(track, measurements_params, config);
      
      X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
      Dx0 = eye(11);
      KFilter(i) = PDKalmanFilter3D_T_corr(track, config, [X0;track.poits(1).true_ToT;0], Dx0, sigma_ksi, measurements_params.period_sec, measurements_params.s_ksi*config.c);
      leg{i} = ['s = ' num2str(s_ksi(i))];
      Dx{i} = KFilter(i).Dx_last;
  end
  
  Dx0 = eye(9);

KFilter(length(s_ksi)+1) = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);
Dx{length(s_ksi)+1} = KFilter(length(s_ksi)+1).Dx_last;
KFilter(length(s_ksi)+2) = RDKalmanFilter3Dd(track, config, X0, Dx0, sigma_ksi);
Dx{length(s_ksi)+2} = KFilter(length(s_ksi)+2).Dx_last;
  
  for i = 1:length(s_ksi)
      measurements_params.s_ksi = s_ksi(i);
      track = make_measurements_for_track(track, measurements_params, config);
      
      X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
      Dx0 = eye(11);
      KFilter(i) = PDKalmanFilter3D_T_corr(track, config, [X0;track.poits(1).true_ToT;0], Dx{i}, sigma_ksi, measurements_params.period_sec, measurements_params.s_ksi*config.c);
      leg{i} = ['s = ' num2str(s_ksi(i)) '1/ñåê'];
  end
  
  leg{length(s_ksi)+1} = 'ÐÄÔ';
  leg{length(s_ksi)+2} = 'ÄÔ';
 Dx0 = eye(9);
KFilter(length(s_ksi)+1) = RDKalmanFilter3D(track, config, X0, Dx{length(s_ksi)+1}, sigma_ksi);
KFilter(length(s_ksi)+2) = RDKalmanFilter3Dd(track, config, X0, Dx{length(s_ksi)+2}, sigma_ksi);
err_comparison_d_pd(track,KFilter,leg,config,s_ksi)

figure
subplot(121)
show_posts2D
show_track2D(track)
% for i = length(KFilter)-1:-1:1
%     plot(KFilter(i).crd(1,:)/1000,KFilter(i).crd(2,:)/1000,'.-')
% end
grid minor
  set(gca,'FontSize',18)
    set(gca,'FontName','Times')
subplot(122)
show_posts2D
% show_track2D(track)
for i = length(KFilter)-1:-1:1
    plot(KFilter(i).crd(1,:)/1000,KFilter(i).crd(2,:)/1000,'.-')
end
plot(KFilter(end).crd(1,:)/1000,KFilter(end).crd(2,:)/1000,'.-')
grid minor
  set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    legend(['ÏÏ' leg(end-1:-1:1) leg(end)])