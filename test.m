clear all
config = Config(); % конфиг содержит координаты постов


% traj_params.X0 = [randi([-100 100]);randi([-100 100])]*1e3; % начальные координаты, м
traj_params.X0 = [20; 40]*1e3; % начальные координаты, м
traj_params.V = 0*200; % скорость, м/c
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
track = make_measurements_for_track(track, measurements_params, config);


X = [];
k = 0;
for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
    if track.poits(i).crd_valid
        k = k + 1;
        X(:,k) = track.poits(i).est_crd;
    end
end

figure
plot(X')
[mean(X')' std(X')']


% построим графики
figure
get_rd_from_poits(track.poits);
%2D
figure
show_posts2D
show_track2D(track)
% show_hyperb_poits(track.poits(1:30), config)
show_primary_points2D(track.poits)