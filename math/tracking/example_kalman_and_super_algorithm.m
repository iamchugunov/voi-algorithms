%% создать один трек
clear all
close all
  config = Config(); % конфиг содержит координаты постов
  % формирование траектории
  traj_params.X0 = [50e3; -50e3]; % начальные координаты, м
  traj_params.V = 200; % скорость, м/c
  traj_params.kurs = 120; % направление, град
  traj_params.h = 10e3; % высота над уровнем моря, м
  traj_params.time_interval = [0 600]; % временной отрезок, сек
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
  process_params.ab = [0.6 0.6];

  
  
 [t, X, Xf] = process_track(track, config, process_params);
  for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
  end
  X_true = true_params(track,t);
%{
  show_posts2D
  show_primary_points2D(track.poits)
  plot(KFilter_res_rd.X(1,:)/1000,KFilter_res_rd.X(4,:)/1000,'r.-')
  plot(X(1,:)/1000,X(3,:)/1000,'b.-')
  show_track2D(track)
%}  
  err_x_rd = KFilter_res_rd.X([1 4 7],:) - [track.poits.true_crd];
  err_v_rd = KFilter_res_rd.X([2 5 8],:) - [track.poits.true_vel];
  err_x_ab = X([1 3 5],:) - X_true([1 3 5],:);
  err_v_ab = X([2 4 6],:) - X_true([2 4 6],:);
  
  %{
  figure
  plot(KFilter_res_rd.t,3*sqrt(KFilter_res_rd.Dx(1,:)))
  hold on
  plot([track.poits.Frame],err_x_rd(1,:),'.-')
  %}
  figure
  subplot(2,1,1)
  plot(KFilter_res_rd.t,err_x_rd,'-r')
  hold on
  plot(t,err_x_ab,'-b')
  xlabel('t, c')
  ylabel('error X, м')

  subplot(2,1,2)
  plot(KFilter_res_rd.t,err_v_rd,'-r')
  hold on
  plot(t,err_v_ab,'-b')
  xlabel('t, c')
  ylabel('error V, м/с')
  

    
