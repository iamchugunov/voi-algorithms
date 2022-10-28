%% создать один трек
  config = Config(); % конфиг содержит координаты постов
  % формирование траектории
  traj_params.X0 = [25e3; -50e3]; % начальные координаты, м
  traj_params.V = 0*200; % скорость, м/c
  traj_params.kurs = 120; % направление, град
  traj_params.h = 10e3; % высота над уровнем моря, м
  traj_params.time_interval = [0 300]; % временной отрезок, сек
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  
  measurements_params.sigma_n_ns = 10;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  track = make_measurements_for_track(track, measurements_params, config);
  
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
  KFilter_res_rd = RDKalmanFilter3D(track, config, X0, 0.1);
  X0 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);
      track.poits(1).true_ToT];
  KFilter_res_pd = PDKalmanFilter3D_T(track, config, X0, 0.1);
  for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
  end
  show_posts2D
  plot(KFilter_res_rd.X(1,:)/1000,KFilter_res_rd.X(4,:)/1000,'r.-')
  plot(KFilter_res_pd.X(1,:)/1000,KFilter_res_pd.X(4,:)/1000,'b.-')
  show_track2D(track)
  
%%