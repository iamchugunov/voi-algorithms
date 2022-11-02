%% Моделируем траектории и расчет первичных точек
clear all
config = Config(); % конфиг содержит координаты постов
h = [1000:1000:20000];
N = 10;
show_posts3D
for i = 1:N
    traj_params.X0 = [50e3; -50e3]; % начальные координаты, м
    traj_params.V = 200; % скорость, м/c
    traj_params.kurs = 90; % направление, град
    traj_params.h = h(i); % высота над уровнем моря, м
    traj_params.time_interval = [0 600]; % временной отрезок, сек
    traj_params.track_id = i;
    track = make_geo_track(traj_params, config);
    show_track3D(track);
    tracks(i) = track;
end

% формирование измерений
measurements_params.sigma_n_ns = 5;
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

for i = 1:length(poits)
    poits(i) = crd_calc(poits(i),config);
end
figure
show_posts3D
show_primary_points3D(poits)


