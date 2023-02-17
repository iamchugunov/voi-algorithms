
clear all
close all
  config = Config(); 
  traj_params.X0 = [50e3; -50e3]; 
  traj_params.V = 200; 
  traj_params.kurs = 120; 
  traj_params.h = 10e3; 
  traj_params.time_interval = [0 600];
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  
  measurements_params.sigma_n_ns = 10;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  measurements_params.s_ksi = 1e-11;
  track = make_measurements_for_track(track, measurements_params, config);
  
  sigma_ksi = 100;
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  KFilter_res_rd = RDKalmanFilter3D(track, config, X0, eye(9),sigma_ksi);
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);
      track.poits(1).true_ToT];
  KFilter_res_pd = PDKalmanFilter3D_T(track, config, X0, eye(10), sigma_ksi, 0.1);
  for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
  end
  show_posts2D
  plot(KFilter_res_rd.X(1,:)/1000,KFilter_res_rd.X(4,:)/1000,'r.-')
  plot(KFilter_res_pd.X(1,:)/1000,KFilter_res_pd.X(4,:)/1000,'b.-')
  show_track2D(track)
  
  err_x_rd = KFilter_res_rd.X([1 4 7],:) - [track.poits.true_crd];
  err_v_rd = KFilter_res_rd.X([2 5 8],:) - [track.poits.true_vel];
  err_x_pd = KFilter_res_pd.X([1 4 7],:) - [track.poits.true_crd];
  err_v_pd = KFilter_res_pd.X([2 5 8],:) - [track.poits.true_vel];
  
  figure
  plot(KFilter_res_rd.t,3*sqrt(KFilter_res_rd.Dx(1,:)))
  hold on
  plot([track.poits.Frame],err_x_rd(1,:),'.-')
   figure
  plot(KFilter_res_pd.t,3*sqrt(KFilter_res_pd.Dx(1,:)))
  hold on
  plot([track.poits.Frame],err_x_pd(1,:),'.-')
  
  
%%
clear all
close all
  config = Config(); 
  traj_params.X0 = [50e3; -50e3]; 
  traj_params.V = 200; 
  traj_params.kurs = 50; 
  traj_params.h = 10e3; 
  traj_params.time_interval = [0 600];
  traj_params.track_id = 0;
  traj_params.maneurs(1) = struct('t0',200,'t',230,'acc',0,'omega',0.6);
  traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
  track = make_geo_track_new(traj_params, config);
  
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  measurements_params.s_ksi = 1e-13;
  track = make_measurements_for_track(track, measurements_params, config);
  
  params.mode = 0;
  params.percentage = [0 0 1];
  params.banned_post = 1;
  [track.poits, res] = thinning_measurements(track.poits, params, config);
  
  sigma_ksi = 10;
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  KFilter_res_rd = RDKalmanFilter3D(track, config, X0, eye(9), sigma_ksi);
  for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
    if track.poits(i).crd_valid
        tdop(i) = track.poits(i).res.dop.TDOP;
    else
        tdop(i) = NaN;
    end
  end
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);
      track.poits(1).true_ToT];
  KFilter_res_pd = PDKalmanFilter3D_T(track, config, X0, eye(10), sigma_ksi, measurements_params.period_sec);
  
  show_posts2D
  show_primary_points2D(track.poits)
  plot(KFilter_res_rd.X(1,:)/1000,KFilter_res_rd.X(4,:)/1000,'r.-')
  plot(KFilter_res_pd.X(1,:)/1000,KFilter_res_pd.X(4,:)/1000,'b.-')
  show_track2D(track)
  
  [err] = err_calc(track, KFilter_res_rd,config);
  [err] = err_calc(track, KFilter_res_pd,config);
  
%   err_x_rd = KFilter_res_rd.X([1 4 7],:) - [track.poits.true_crd];
%   err_v_rd = KFilter_res_rd.X([2 5 8],:) - [track.poits.true_vel];
%   err_x_pd = KFilter_res_pd.X([1 4 7],:) - [track.poits.true_crd];
%   err_v_pd = KFilter_res_pd.X([2 5 8],:) - [track.poits.true_vel];
%   
%   figure
%   subplot(121)
%   plot(KFilter_res_rd.t,3*sqrt(KFilter_res_rd.Dx(1,:)))
%   hold on
%   plot([track.poits.Frame],err_x_rd(1,:),'.-')
%   subplot(122)
%   plot(KFilter_res_pd.t,3*sqrt(KFilter_res_pd.Dx(1,:)))
%   hold on
%   plot([track.poits.Frame],err_x_pd(1,:),'.-')
%   title('x')
%   
%   figure
%   subplot(121)
%   plot(KFilter_res_rd.t,3*sqrt(KFilter_res_rd.Dx(7,:)))
%   hold on
%   plot([track.poits.Frame],err_x_rd(3,:),'.-')
%   subplot(122)
%   plot(KFilter_res_pd.t,3*sqrt(KFilter_res_pd.Dx(7,:)))
%   hold on
%   plot([track.poits.Frame],err_x_pd(3,:),'.-')
%   title('z')
%   
%   figure
%   subplot(121)
%   plot(KFilter_res_rd.t,3*sqrt(KFilter_res_rd.Dx(2,:)))
%   hold on
%   plot([track.poits.Frame],err_v_rd(1,:),'.-')
%   subplot(122)
%   plot(KFilter_res_pd.t,3*sqrt(KFilter_res_pd.Dx(2,:)))
%   hold on
%   plot([track.poits.Frame],err_v_pd(1,:),'.-')
%   title('vx')
%   
%   figure
%   plot([track.poits.Frame],[track.poits.est_ToT] - [track.poits.true_ToT])
%   hold on
%   plot([track.poits.Frame],3*tdop * 1e-9 * config.sigma_n_ns)
%   plot(KFilter_res_pd.t,KFilter_res_pd.err(end,:)/config.c)
%   plot(KFilter_res_pd.t,3*sqrt(KFilter_res_pd.Dx(10,:))/config.c)
%   title('T')
  
  %%
  clear all
  close all
  config = Config();
  traj_params.X0 = [100e3; -100e3];
%   traj_params.X0 = [0e3; -40e3];
  traj_params.V = 200;
  traj_params.kurs = 130;
  traj_params.h = 10e3;
  traj_params.time_interval = [0 600];
  traj_params.track_id = 0;
%   traj_params.maneurs(1) = struct('t0',200,'t',230,'acc',0,'omega',0.6);
%   traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
  traj_params.maneurs(1) = struct('t0',200,'t',400,'acc',0,'omega',2);
%   traj_params.maneurs = [];
  track = make_geo_track_new(traj_params, config);
  
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  measurements_params.s_ksi = 1e-8;
  track = make_measurements_for_track(track, measurements_params, config);
  
  params.mode = 0;
  params.percentage = [1 0 0];
  params.banned_post = 3;
%   [track.poits, res] = thinning_measurements(track.poits, params, config);
  
  
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  [res] = nonlinear_approx_rdm(track.poits(1:300), config, X0);
  sigma_ksi = 10;
  KFilter_res_rd1 = RDKalmanFilter3D(track, config, X0, eye(9), sigma_ksi);
  sigma_ksi = 0.0;
  KFilter_res_rd2 = RDKalmanFilter3D(track, config, X0, eye(9), sigma_ksi);
%   for i = 1:length(track.poits)
%     track.poits(i) = crd_calc(track.poits(i),config);
%   end
  
  show_posts2D
  show_primary_points2D(track.poits)
  plot(KFilter_res_rd1.X(1,:)/1000,KFilter_res_rd1.X(4,:)/1000,'r.-')
  plot(KFilter_res_rd2.X(1,:)/1000,KFilter_res_rd2.X(4,:)/1000,'b.-')
  show_track2D(track)
  
  [err] = err_calc(track, KFilter_res_rd1,config);
  [err] = err_calc(track, KFilter_res_rd2,config);
  
  
