clear all
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
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.5;
measurements_params.n_periods = 20;
measurements_params.strob_dur = 0.12;

for i = 1:N
    tracks(i) = make_measurements_for_track(tracks(i), measurements_params, config);
end

%объединение измерений
[poits] = merge_measurements(tracks);
figure
get_rd_from_poits(poits);