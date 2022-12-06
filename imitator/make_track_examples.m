%% make one track
  config = Config(); 
  % track constructor
  traj_params.X0 = [50e3; -50e3]; % 
  traj_params.V = 200; % 
  traj_params.kurs = 120; % 
  traj_params.h = 10e3; % 
  traj_params.time_interval = [0 600]; % 
  traj_params.track_id = 0;
  track = make_geo_track(traj_params, config);
  % visual
  %2D
  figure
  show_posts2D
  show_track2D(track)
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
    track = make_geo_track(traj_params, config);
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