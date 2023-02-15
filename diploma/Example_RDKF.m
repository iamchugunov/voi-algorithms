%% track
clear all
close all
config = Config();
traj_params.X0 = [50e3; -50e3]; 
traj_params.V = 200; 
traj_params.kurs = 90; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 35]; 

traj_params.track_id = 0;

% traj_params.maneurs(1) = struct('t0',100,'t',200,'acc',0,'omega',0.6);
% traj_params.maneurs(2) = struct('t0',300,'t',400,'acc',0,'omega',-0.3);
% traj_params.maneurs(3) = struct('t0',500,'t',600,'acc',0.5,'omega',0);

%traj_params.maneurs(1) = struct('t0',1,'t',600,'acc',0,'omega',0.6);
traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
%% thinning track
% params.mode = 0;
% params.percentage = [0 0.5 0.5];
% params.banned_post = 2;
% [track.poits, res] = thinning_measurements(track.poits, params, config);
%%
X0 = [track.crd(1,1);track.vel(1,1);
      track.crd(2,2);track.vel(2,2);
      track.crd(3,3);track.vel(3,3);];
sigma_Dx0 = 10;
Dx0 = sigma_Dx0*eye(9,9); 
s_ksi = 1;

paramsT.T_nak = 30;
paramsT.T = 5;

Filter = RDKF_Accum(track, config, s_ksi, X0, Dx0, paramsT);

show_posts2D
show_track2D(track)
hold on
plot(Filter.crd(1,:)/1000,Filter.crd(2,:)/1000, "r-")