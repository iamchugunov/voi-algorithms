
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
  
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  track = make_measurements_for_track(track, measurements_params, config);
  %%
  sigma_ksi = 1;
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  KFilter_res_rd = RDKalmanFilter3D(track, config, X0, sigma_ksi);
  process_params.T_nak = 30;
  process_params.T_res = 5;
  process_params.ab = [0.5 0.5];
 [t, X, Xf] = process_track(track, config, process_params);
  for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
  end
  show_posts2D
  show_primary_points2D(track.poits)
  plot(KFilter_res_rd.X(1,:)/1000,KFilter_res_rd.X(4,:)/1000,'r.-')
  plot(X(1,:)/1000,X(3,:)/1000,'b.-')
  show_track2D(track)
  
  err_x_rd = KFilter_res_rd.X([1 4 7],:) - [track.poits.true_crd];
  err_v_rd = KFilter_res_rd.X([2 5 8],:) - [track.poits.true_vel];
  err_x_ab = X([1 3 5],:) - [track.poits.true_crd];
  err_v_ab = X([2 4 6],:) - [track.poits.true_vel];
  
%   figure
%   plot(KFilter_res_rd.t,3*sqrt(KFilter_res_rd.Dx(1,:)))
%   hold on
%   plot([track.poits.Frame],err_x_rd(1,:),'.-')
figure
plot(KFilter_res_rd.t,err_x_rd')
hold on
plot(t,err_x_ab')
figure
plot(KFilter_res_rd.t,err_v_rd')
hold on
plot(t,err_v_ab')