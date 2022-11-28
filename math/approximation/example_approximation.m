%% создать один трек
close all
clear all
  config = Config(); % конфиг содержит координаты постов
  % формирование траектории
  traj_params.X0 = [50e3; -50e3]; % начальные координаты, м
  traj_params.V = 200; % скорость, м/c
  traj_params.kurs = 120; % направление, град
  traj_params.h = 10e3; % высота над уровнем моря, м
  traj_params.time_interval = [0 10]; % временной отрезок, сек
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  % построим графики
  %2D
  figure
  show_posts2D
  show_track2D(track)
  %3D
  figure
  show_posts3D
  show_track3D(track)
  show_track_dop(track)
  % формирование измерений
  
  config.sigma_n_ns = 10;
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)
  
  % аппроксимация
  % начальное приближение
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
  [X, R] = nonlinear_approx_rdm(track.poits, config, X0);
%% расчет для статичной точки
close all
clear all
  config = Config(); % конфиг содержит координаты постов
  % формирование траектории
  traj_params.X0 = [50e3; -50e3]; % начальные координаты, м
  traj_params.V = 0; % скорость, м/c
  traj_params.kurs = 120; % направление, град
  traj_params.h = 10e3; % высота над уровнем моря, м
  traj_params.time_interval = [0 10]; % временной отрезок, сек
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  % построим графики
  %2D
  figure
  show_posts2D
  show_track2D(track)
  %3D
  figure
  show_posts3D
  show_track3D(track)
  show_track_dop(track)
  % формирование измерений
  
  config.sigma_n_ns = 10;
  measurements_params.sigma_n_ns = config.sigma_n_ns;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)
  
  % аппроксимация
  % начальное приближение
  X0 = track.crd(:,1);
  X0 = [40e3;-40e3;10000];
%   X0 = [50000;50;0;-50000;-50;0;10000;0;0];
  [X, R] = nonlinear_approx_rdm0(track.poits(1), config, X0);
  [track.crd(:,1) X R]
%% проверка погрешности статика
close all
clear all
config = Config(); % конфиг содержит координаты постов
% формирование траектории
traj_params.X0 = [50e3; -50e3]; % начальные координаты, м
traj_params.V = 200*0; % скорость, м/c
traj_params.kurs = 120; % направление, град
traj_params.h = 10e3; % высота над уровнем моря, м
traj_params.time_interval = [0 10]; % временной отрезок, сек
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
  [X(:,i), R(:,i)] = nonlinear_approx_rdm0(track.poits, config, X0);
  end
[mean(R')' std(X')']
%% проверка погрешности - v const
close all
clear all
config = Config(); % конфиг содержит координаты постов
% формирование траектории
traj_params.X0 = [100e3; -100e3]; % начальные координаты, м
traj_params.V = 200; % скорость, м/c
traj_params.kurs = 120; % направление, град
traj_params.h = 10e3; % высота над уровнем моря, м
traj_params.time_interval = [0 10]; % временной отрезок, сек
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
 
  [X(:,i), R(:,i)] = nonlinear_approx_rdm1(track.poits, config, X0);
  end
 [mean(R')' std(X')']