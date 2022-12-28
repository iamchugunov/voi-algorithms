% test old
close all
clear all
config = Config();
traj_params.X0 = [100e3; -70e3];
traj_params.V = 200;
traj_params.kurs = 120;
traj_params.h = 10e3;
traj_params.time_interval = [0 30];
traj_params.track_id = 0;
traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);
%2D
figure
show_posts2D
show_track2D(track)

config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);

for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
end
show_primary_points2D(track.poits)

X_true = [track.crd(1,1);
    track.crd(2,1);
    track.crd(3,1);];

X = [];
k = 0;
for x = 80e3:1e3:120e3
    for y = -90e3:1e3:-50e3
        X0 = [x;y;X_true(3)];
        res = nonlinear_approx_rdm(track.poits, config, X0);
        if norm(res.X - X_true) < 10000
            k = k + 1;
            X(:,k) = X0;
        end
    end
end
