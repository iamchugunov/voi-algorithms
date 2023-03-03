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
clear all
close all
config = Config();
traj_params.X0 = [0; -100e3];
traj_params.V = 200;
traj_params.kurs = 0;
traj_params.h = 10e3;
traj_params.time_interval = [0 3800];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',1,'t',2500,'acc',0,'omega',0.12);
traj_params.maneurs(2) = struct('t0',2500,'t',2680,'acc',0,'omega',0.6);
traj_params.maneurs(3) = struct('t0',2900,'t',2950,'acc',0,'omega',1.4);
traj_params.maneurs(4) = struct('t0',2950,'t',3500,'acc',0,'omega',-0.5);
traj_params.maneurs(5) = struct('t0',3500,'t',3547,'acc',0,'omega',1.4);
track = make_geo_track_new(traj_params, config);

show_posts3D
show_track3D(track)
%%
close all
traj_params.V = 0;
track = make_geo_track_new(traj_params, config);
show_posts3D
show_track3D(track)
%%
close all
traj_params.V = 200;
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
get_rd_from_poits(track.poits)
%% DX CALC
sigma_ksi = 0.1;

  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  
  Dx0 = eye(9);
  
  [KFilter1] = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);
  Dx1 = KFilter1.Dx_last;
  
  [KFilter2] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,1000);
  Dx2 = KFilter2.Dx_last;
  
  [KFilter3] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,500);
  Dx3 = KFilter3.Dx_last;

  [KFilter4] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,100);
  Dx4 = KFilter4.Dx_last;
  
  [KFilter5] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,50);
  Dx5 = KFilter5.Dx_last;
 
  [KFilter6] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,10);
  Dx6 = KFilter6.Dx_last;
 
  [KFilter7] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,1);
  Dx7 = KFilter7.Dx_last;
%%
close all
poits = track.poits;

for i = 1:length(poits)
    poits(i) = crd_calc(poits(i),config);
end
sigma_ksi = 0.1;

  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
 
  [KFilter1] = RDKalmanFilter3D(track, config, X0, Dx1, sigma_ksi);
  
  for i = 1:length(track.poits)
      track.poits(i).h_geo = traj_params.h + normrnd(0,1000);
  end
  [KFilter2] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx2, sigma_ksi,1000);
  
  for i = 1:length(track.poits)
      track.poits(i).h_geo = traj_params.h + normrnd(0,500);
  end
  [KFilter3] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx3, sigma_ksi,500);
  
  for i = 1:length(track.poits)
      track.poits(i).h_geo = traj_params.h + normrnd(0,100);
  end
  [KFilter4] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx4, sigma_ksi,100);
  
  for i = 1:length(track.poits)
      track.poits(i).h_geo = traj_params.h + normrnd(0,50);
  end
  [KFilter5] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx5, sigma_ksi,50);
  
  for i = 1:length(track.poits)
      track.poits(i).h_geo = traj_params.h + normrnd(0,10);
  end
  [KFilter6] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx6, sigma_ksi,10);
  
  for i = 1:length(track.poits)
      track.poits(i).h_geo = traj_params.h + normrnd(0,1);
  end
  [KFilter7] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx7, sigma_ksi,1);



show_posts2D
show_primary_points2D(poits)
show_track2D(track)
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'.-')
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'.-')

  [err] = err_calc_dist(track, KFilter1,config);
  [err] = err_calc_dist(track, KFilter2,config);
  [err] = err_calc_dist(track, KFilter3,config);
  [err] = err_calc_dist(track, KFilter4,config);
  [err] = err_calc_dist(track, KFilter5,config);
   [err] = err_calc_dist(track, KFilter6,config);
    [err] = err_calc_dist(track, KFilter7,config);
  [err] = err_calc_poits(track, poits,config);
  err_comparison_d([KFilter1 KFilter2 KFilter3 KFilter4 KFilter5 KFilter6 KFilter7],{'s = 1000 ì', 's = 500 ì', 's = 100 ì', 's = 50 ì', 's = 10 ì', 's = 1 ì', 'ÐÄÔ'})