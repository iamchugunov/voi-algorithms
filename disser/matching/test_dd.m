config = Config();
config.posts(:,1) = [-5; 0; 0.015]*1e3;
config.posts(:,2) = [5; 0; 0.015]*1e3;
config.posts(:,3:4) = [];
show_posts2D

%%
x = -30e3;
y = -10e3*0;
h = 10e3;
z = h_geo_calc(x,y,h);
X = [x;y;z];
V = 200;
alpha = 0:45:315;

figure
hold on
grid minor
dd = [];
leg = [];
for j = 1:length(alpha)
    t = 0.1:0.1:10;
    for i = 1:length(t)
        [dd{j}(i), ~] = calc_delta_rd(config, X, V, alpha(j), t(i));
    end
    leg{j} = num2str(alpha(j));
    plot(t,(dd{j}))
end
legend(leg)
%%
clear all
close all
config = Config();
traj_params.X0 = [150e3; -150e3]/3;
traj_params.V = 200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [0 1000];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',1200,'t',2000,'acc',0,'omega',0.3);
% traj_params.maneurs(2) = struct('t0',400,'t',450,'acc',0,'omega',0.6);
traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);

show_posts3D
show_track3D(track)
%%
clear all
close all
config = Config();
traj_params.X0 = [60e3; -100e3];
traj_params.V = 200;
traj_params.kurs = 60;

traj_params.h = 10e3;
traj_params.time_interval = [0 1900];
traj_params.track_id = 0;
traj_params.maneurs(1) = struct('t0',200,'t',350,'acc',0,'omega',0.6);
traj_params.maneurs(2) = struct('t0',600,'t',650,'acc',0,'omega',-0.5);
traj_params.maneurs(3) = struct('t0',750,'t',1300,'acc',0,'omega',0.6);
traj_params.maneurs(4) = struct('t0',1300,'t',1425,'acc',0,'omega',1.4);
track = make_geo_track_new(traj_params, config);

show_posts3D
show_track3D(track)
%%
config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.012;
measurements_params.s_ksi = 1e-8*0;
track = make_measurements_for_track(track, measurements_params, config);