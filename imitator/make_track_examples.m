%% создать один трек
  config = Config(); % конфиг содержит координаты постов
  % формирование траектории
  traj_params.X0 = [50e3; -50e3]; % начальные координаты, м
  traj_params.V = 200; % скорость, м/c
  traj_params.kurs = 120; % направление, град
  traj_params.h = 10e3; % высота над уровнем моря, м
  traj_params.time_interval = [0 600]; % временной отрезок, сек
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
  
  measurements_params.sigma_n_ns = 10;
  measurements_params.period_sec = 0.1;
  measurements_params.n_periods = 0;
  measurements_params.strob_dur = 0.12;
  track = make_measurements_for_track(track, measurements_params, config);
  figure
  get_rd_from_poits(track.poits)

%% формирование N траекторий случайным образом
config = Config(); % конфиг содержит координаты постов

N = 10;
show_posts3D
for i = 1:N
    traj_params.X0 = [randi([-100 100]);randi([-100 100])]*1e3; % начальные координаты, м
    traj_params.V = 200 + randi([-50 50]); % скорость, м/c
    traj_params.kurs = randi([0 35])*10; % направление, град
    traj_params.h = 10e3 + 500 * randi([-4 4]); % высота над уровнем моря, м
    traj_params.time_interval = [0 600]; % временной отрезок, сек
    traj_params.track_id = i;
    track = make_geo_track(traj_params, config);
    show_track3D(track);
    tracks(i) = track;
end

% формирование измерений
measurements_params.sigma_n_ns = 10;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 10;
measurements_params.strob_dur = 0.12;

for i = 1:N
    tracks(i) = make_measurements_for_track(tracks(i), measurements_params, config);
end

%объединение измерений
[poits] = merge_measurements(tracks);
figure
get_rd_from_poits(poits);
%%