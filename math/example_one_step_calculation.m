%% Моделируем траектории и расчет первичных точек
clear all
config = Config(); % конфиг содержит координаты постов
N = 10;
show_posts3D
for i = 1:N
    traj_params.X0 = [randi([-150 150]);randi([-50 50])]*1e3; % начальные координаты, м
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

for i = 1:length(poits)
    poits(i) = crd_calc(poits(i),config);
end
figure
show_posts3D
show_primary_points3D(poits)
%% расчет в стационарной точке
clear all
config = Config(); % конфиг содержит координаты постов

% traj_params.X0 = [randi([-100 100]);randi([-100 100])]*1e3; % начальные координаты, м
traj_params.X0 = [150; 150]*1e3; % начальные координаты, м
traj_params.V = 0; % скорость, м/c
traj_params.kurs = 120; % направление, град
traj_params.h = 10e3; % высота над уровнем моря, м
traj_params.time_interval = [0 1000]; % временной отрезок, сек
traj_params.track_id = 0;
track = make_geo_track(traj_params, config);

% формирование измерений

measurements_params.sigma_n_ns = 30;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 10;
measurements_params.strob_dur = 0.12;
% measurements_params.strob_dur = 1e8;
track = make_measurements_for_track(track, measurements_params, config);


for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
end

% построим графики
figure
get_rd_from_poits(track.poits)
%2D
figure
show_posts2D
show_track2D(track)
% show_hyperb_poits(track.poits(1:30), config)
show_primary_points2D(track.poits)
figure
nms = find([track.poits.crd_valid]);
plot([track.poits(nms).true_ToT] - [track.poits(nms).est_ToT],'.')
figure
plot([track.poits(nms).true_crd]' - [track.poits(nms).est_crd]','.')