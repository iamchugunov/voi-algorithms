%%
% static
close all
clear all
config = Config();
traj_params.X0 = [50e3; -50e3];
traj_params.V = 0;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [1 30];
traj_params.track_id = 0;
traj_params.maneurs = [];
% traj_params.maneurs(1) = struct('t0',1,'t',30,'acc',0,'omega',1);
% traj_params.maneurs(2) = struct('t0',600,'t',800,'acc',0,'omega',-0.1);
track = make_geo_track_new(traj_params, config);
config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
for i = 1:length(track.t)
    R(i) = norm(track.crd(1:2,i));
end
plot(R/1000)
show_posts2D
show_track2D(track)
%% proverka rabotosposobnosti
% ispolsuem staticheskuy tochku dlya vseh poryadkov

for i = 1:100
    fprintf("=");
end
fprintf("\n");

tic
X0 = [track.crd(1,1);
    track.crd(2,1);
    track.crd(3,1);];
measurements_params.sigma_n_ns = config.sigma_n_ns * 0;
track = make_measurements_for_track(track, measurements_params, config);
res1 = nonlinear_approx_rdm(track.poits, config, X0);
measurements_params.sigma_n_ns = config.sigma_n_ns;
X1 = [];
R1 = [];
for i = 1:100
    fprintf("=");
    track = make_measurements_for_track(track, measurements_params, config);
    res = nonlinear_approx_rdm(track.poits, config, X0);
    X1(:,i) = res.X;
    R1(:,i) = res.R;
end
fprintf("\n");
toc

tic
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
measurements_params.sigma_n_ns = config.sigma_n_ns * 0;
track = make_measurements_for_track(track, measurements_params, config);
res2 = nonlinear_approx_rdm(track.poits, config, X0);
measurements_params.sigma_n_ns = config.sigma_n_ns;
X2 = [];
R2 = [];
for i = 1:100
    fprintf("=");
    track = make_measurements_for_track(track, measurements_params, config);
    res = nonlinear_approx_rdm(track.poits, config, X0);
    X2(:,i) = res.X;
    R2(:,i) = res.R;
end
fprintf("\n");
toc

tic
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.acc(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.acc(2,1);
    track.crd(3,1);
    track.vel(3,1);
    track.acc(3,1);];
measurements_params.sigma_n_ns = config.sigma_n_ns * 0;
track = make_measurements_for_track(track, measurements_params, config);
res3 = nonlinear_approx_rdm(track.poits, config, X0);
measurements_params.sigma_n_ns = config.sigma_n_ns;
X3 = [];
R3 = [];
for i = 1:100
    fprintf("=");
    track = make_measurements_for_track(track, measurements_params, config);
    res = nonlinear_approx_rdm(track.poits, config, X0);
    X3(:,i) = res.X;
    R3(:,i) = res.R;
end
fprintf("\n");
toc
[res1.R mean(R1')' std(R1')' std(X1')']
[res2.R mean(R2')' std(R2')' std(X2')']
[res3.R mean(R3')' std(R3')' std(X3')']
%%
% v const
close all
clear all
config = Config();
traj_params.X0 = [50e3; -50e3];
traj_params.V = 200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [1 31];
traj_params.track_id = 0;
traj_params.maneurs = [];
% traj_params.maneurs(1) = struct('t0',1,'t',30,'acc',0,'omega',1);
% traj_params.maneurs(2) = struct('t0',600,'t',800,'acc',0,'omega',-0.1);
track = make_geo_track_new(traj_params, config);
config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
for i = 1:length(track.t)
    R(i) = norm(track.crd(1:2,i));
end
plot(R/1000)
show_posts2D
show_track2D(track)
%%
X0 = [track.crd(1,1);
    track.crd(2,1);
    track.crd(3,1);];
measurements_params.sigma_n_ns = config.sigma_n_ns * 0;
track = make_measurements_for_track(track, measurements_params, config);
res1 = nonlinear_approx_rdm(track.poits, config, X0);
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
res2 = nonlinear_approx_rdm(track.poits, config, X0);
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.acc(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.acc(2,1);
    track.crd(3,1);
    track.vel(3,1);
    track.acc(3,1);];
measurements_params.sigma_n_ns = config.sigma_n_ns * 0;
track = make_measurements_for_track(track, measurements_params, config);
res3 = nonlinear_approx_rdm(track.poits, config, X0);
[res1.R res1.X]
[res2.R res2.X]
[res3.R res3.X]