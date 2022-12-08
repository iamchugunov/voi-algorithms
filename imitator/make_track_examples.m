%% make one track
close all
clear all
  config = Config(); 
  % track constructor
  traj_params.X0 = [50e3; -50e3]; % 
  traj_params.V = 200; % 
  traj_params.kurs = 120; % 
  traj_params.h = 10e3; % 
  traj_params.time_interval = [0 30]; % 
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  % visual
  %2D
  figure
  show_posts2D
  show_track2D(track)

  show_mod_V(traj_params,track)
  %3D
  figure
  show_posts3D
  show_track3D(track)
  show_track_dop(track)

  % measurements constructor
  
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  measurements_params.s_ksi = 1e-6;
  track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)

%% N random tracks
config = Config(); 

N = 10;
show_posts3D
for i = 1:N
    traj_params.X0 = [randi([-100 100]);randi([-100 100])]*1e3; 
    traj_params.V = 200 + randi([-50 50]); 
    traj_params.kurs = randi([0 35])*10; 
    traj_params.h = 10e3 + 500 * randi([-4 4]); 
    traj_params.time_interval = [0 600]; 
    traj_params.track_id = i;
    traj_params.count_mnv = 4;
    traj_params.type_mnv = [1 2];
    traj_params.omega = 0.6; % скорость изменения угла, градус в секунду
    traj_params.type_moov = [1 2 3];
    traj_params.acc_moov = 0.5; % ускорение м/с^2
    traj_params.dh = 20; %условное обозначние что за единицу времени высота изменится на n метров
    traj_params.type_dh = [1 2 3];
    track = make_geo_ultima(traj_params, config);
    show_track3D(track);
    tracks(i) = track;
end

measurements_params.sigma_n_ns = 10;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 10;
measurements_params.strob_dur = 0.12;

for i = 1:N
    tracks(i) = make_measurements_for_track(tracks(i), measurements_params, config);
end

% combining measurements
[poits] = merge_measurements(tracks);
figure
get_rd_from_poits(poits);

%% манёвренные траектория 

config = Config(); % конфиг содержит координаты постов
  % формирование траектории
  traj_params.X0 = [50e3; -50e3]; % начальные координаты, м
  traj_params.V = 200; % скорость, м/c
  traj_params.kurs = 120; % направление, град
  traj_params.h = 10e3; % высота над уровнем моря, м
  traj_params.time_interval = [0 600]; % временной отрезок, сек
  traj_params.track_id = 0; 
    
  traj_params.maneurs=geo_input();
  
  track = make_geo_track_new(traj_params, config);
  
  % построим графики
  %2D
  figure
  show_posts2D
  show_track2D(track)
  show_mod_V(traj_params,track)
  %3D
  figure
  show_posts3D
  show_track3D(track)
  show_track_dop(track)
  % формирование измерений

  measurements_params.sigma_n_ns = 10;
  measurements_params.period_sec = 1;

  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
   track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)

%%
%% UWB
  config = Config(); 
  config.posts = [0 10 0 10; 0 0 10 10; 0 0 0 0];
  config.sigma_n_ns = 0.1;
  traj_params.X0 = [3.5; 7.6]; 
  traj_params.V = 0.01*0; 
  traj_params.kurs = 120; 
  traj_params.h = 0; 
  traj_params.time_interval = [0 600]; 
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  track.crd(3,:) = 1;
  
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 1000000;
  track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)