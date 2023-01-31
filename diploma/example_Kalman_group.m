%% track
clear all
close all
config = Config();
traj_params.X0 = [50e3; -50e3]; 
traj_params.V = 200; 
traj_params.kurs = 120; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 600]; 
traj_params.track_id = 0;
%{
traj_params.maneurs(1) = struct('t0',100,'t',200,'acc',0,'omega',0.6);
traj_params.maneurs(2) = struct('t0',300,'t',400,'acc',0,'omega',-0.3);
traj_params.maneurs(3) = struct('t0',500,'t',600,'acc',0.5,'omega',0);
%}
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
params.mode = 1;
params.percentage = [0.4 0.5 0.1];
params.banned_post = 1;

[track.poits, res] = thinning_measurements(track.poits, params, config);
subplot(2,1,1)
show_posts2D
show_track2D(track)
%% accumulation
T_nak = 30;
T = 5;

poits = track.poits;
t = [];
X = [];
t_res_last = poits(1).Frame;
k = 0;
for i = 1:length(poits)
    if poits(i).Frame - t_res_last > T_res
        k = k + 1;
        t_res_last = poits(i).Frame;
        current_poits = poits(i);
        k1 = 0;
        for j = 1:i
            if poits(i).Frame - poits(j).Frame < T_nak
                k1 = k1 + 1;
                current_poits(k1) = poits(j);
            end
         end
         t(k) = t_res_last;
         KFilter = RDKalmanFilter3D_group(current_poits, config, X0, Dx0, s_ksi);
    end
end