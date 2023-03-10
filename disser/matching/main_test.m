%% N random tracks
config = Config(); 

N = 10;
show_posts3D
for i = 1:N
    traj_params.X0 = [randi([-100 100]);randi([-100 100])]*1e3; 
    traj_params.V = 200 + randi([-50 50]); 
    traj_params.kurs = randi([0 35])*10; 
    traj_params.h = 10e3 + 100 * randi([-20 20]); 
    traj_params.time_interval = [0 600];
    traj_params.track_id = i;
%     traj_params.maneurs(1) = struct('t0',1200,'t',2000,'acc',0,'omega',0.3);
    % traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
    traj_params.maneurs = [];
    track = make_geo_track_new(traj_params, config);
    show_track3D(track);
    tracks(i) = track;
end

config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 10;
measurements_params.strob_dur = 0.012;
measurements_params.s_ksi = 1e-8*0;

for i = 1:N
    tracks(i) = make_measurements_for_track(tracks(i), measurements_params, config);
end

% combining measurements
[poits] = merge_measurements(tracks);
figure
get_rd_from_poits(poits);