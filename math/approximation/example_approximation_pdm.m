%% static
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

config.sigma_n_ns = 10;

measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0.1*0;



measurements_params.sigma_n_ns = config.sigma_n_ns*0;
track = make_measurements_for_track(track, measurements_params, config);
X0 = track.crd(:,1);
X0 = [track.crd(1,1); track.vel(1,1); track.crd(2,1); track.vel(2,1); track.crd(3,1); track.vel(3,1);];
X0(end+1) = track.poits(1).true_ToT*config.c;
X0(end+1) = measurements_params.period_sec * config.c;
res = nonlinear_approx_pdm(track.poits, config, X0);
[X0 res.X res.R]

measurements_params.sigma_n_ns = config.sigma_n_ns*0.1;
track = make_measurements_for_track(track, measurements_params, config);
X0 = track.crd(:,1);
X0 = [track.crd(1,1); track.vel(1,1); track.crd(2,1); track.vel(2,1); track.crd(3,1); track.vel(3,1);];
X0(end+1) = track.poits(1).true_ToT*config.c;
X0(end+1) = measurements_params.period_sec * config.c;
res = nonlinear_approx_pdm(track.poits, config, X0);
[X0 res.X res.R]

measurements_params.sigma_n_ns = config.sigma_n_ns;
track = make_measurements_for_track(track, measurements_params, config);
X0 = track.crd(:,1);
X0 = [track.crd(1,1); track.vel(1,1); track.crd(2,1); track.vel(2,1); track.crd(3,1); track.vel(3,1);];
X0(end+1) = track.poits(1).true_ToT*config.c;
X0(end+1) = measurements_params.period_sec * config.c;
res = nonlinear_approx_pdm(track.poits, config, X0);
[X0 res.X res.R]

X0 = track.crd(:,1);
X0 = [track.crd(1,1); track.vel(1,1); track.crd(2,1); track.vel(2,1); track.crd(3,1); track.vel(3,1);];
res = nonlinear_approx_rdm(track.poits, config, X0);
[X0 res.X res.R]

 %%
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
  
  config.sigma_n_ns = 10;
  measurements_params.sigma_n_ns = config.sigma_n_ns * 0;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  measurements_params.s_ksi = 0.1*0;
  track = make_measurements_for_track(track, measurements_params, config);
   X0 = [track.crd(1,1);
         track.vel(1,1);
         track.crd(2,1);
         track.vel(2,1);
         track.crd(3,1);
         track.vel(3,1);
         track.poits(1).true_ToT*config.c;
         measurements_params.period_sec * config.c;];
  res0 = nonlinear_approx_pdm(track.poits, config, X0);
  
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  R = [];
  X = [];
  for i = 1:100
      track = make_measurements_for_track(track, measurements_params, config);
      res = nonlinear_approx_pdm(track.poits, config, X0);
      R(:,i) = res.R;
      X(:,i) = res.X;
  end
  
