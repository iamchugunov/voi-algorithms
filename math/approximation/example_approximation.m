
close all
clear all
  config = Config(); 
  traj_params.X0 = [50e3; -50e3]; 
  traj_params.V = 200; 
  traj_params.kurs = 120; 
  traj_params.h = 10e3; 
  traj_params.time_interval = [0 10]; 
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  %2D
  figure
  show_posts2D
  show_track2D(track)
  %3D
  figure
  show_posts3D
  show_track3D(track)
  show_track_dop(track)
  
  config.sigma_n_ns = 10;
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)
  
  X0 = [track.crd(1,1);
      track.vel(1,1);
      track.acc(1,1);
      track.crd(2,1);
      track.vel(2,1);
      track.acc(2,1);
      track.crd(3,1);
      track.vel(3,1);
      track.acc(3,1);];
%   X0 = [50000;50;0;-50000;-50;0;10000;0;0];
    X0([1 3 5],1) = track.crd(:,1);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,1);% + normrnd(0, 10, [3 1]);
  res = nonlinear_approx_rdm(track.poits, config, X0);
%% static
close all
clear all
  config = Config(); 
  traj_params.X0 = [50e3; -50e3]; 
  traj_params.V = 0; 
  traj_params.kurs = 120; 
  traj_params.h = 10e3; 
  traj_params.time_interval = [0 10]; 
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  %2D
  figure
  show_posts2D
  show_track2D(track)
  %3D
  figure
  show_posts3D
  show_track3D(track)
  show_track_dop(track)
  
  config.sigma_n_ns = 10;
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)
  
  X0 = track.crd(:,1);
  X0 = [40e3;-40e3;10000];
%   X0 = [50000;50;0;-50000;-50;0;10000;0;0];
  res = nonlinear_approx_rdm(track.poits(1), config, X0);
  [track.crd(:,1) res.X res.R]
%% accuracy estimation (static)
close all
config = Config(); 
traj_params.X0 = [50e3; -50e3]; 
traj_params.V = 200*0; 
traj_params.kurs = 120; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 10]; 
traj_params.track_id = 0;
track = make_geo_track(traj_params, config);
config.sigma_n_ns = 10;
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  for i = 1:100
      i
  track = make_measurements_for_track(track, measurements_params, config);
  X0 = track.crd(:,1);
  X0(2) = X0(2) + 1000;
  res = nonlinear_approx_rdm(track.poits, config, X0);
  X(:,i) = res.X;
  R(:,i) = res.R;
  end
[mean(R')' std(X')']
%% accuracy estimation - v const
close all
clear all
config = Config(); 
traj_params.X0 = [100e3; -100e3]; 
traj_params.V = 200; 
traj_params.kurs = 120; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 10]; 
traj_params.track_id = 0;
track = make_geo_track(traj_params, config);
config.sigma_n_ns = 10;
  measurements_params.sigma_n_ns = config.sigma_n_ns*0;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  for i = 1:100
      i
  track = make_measurements_for_track(track, measurements_params, config);
  X0([1 3 5],1) = track.crd(:,1);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,1);% + normrnd(0, 10, [3 1]);
 
  res = nonlinear_approx_rdm(track.poits, config, X0);
  X(:,i) = res.X;
  R(:,i) = res.R;
  end
 [mean(R')' std(X')']