close all
clear all
config = Config();
X(:,1) = [-10e3; 10e3; 1e3];
X(:,2) = [100; 7e3; 1e3];
X(:,3) = [10e3; 10e3; 1e3];
X(:,4) = [0;0;0];
config.posts = X;
traj_params.X0 = [100e3; 100e3];
traj_params.V = 0;
traj_params.kurs = 163;
traj_params.h = 0;
traj_params.time_interval = [1 100];
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
params.mode = 1;
params.percentage = [0 0 0];
params.banned_post = 4;
[poits, res] = thinning_measurements(track.poits, params, config);



mnk_params.epsilon = 0.001;
mnk_params.max_iter = 20;
mnk_params.X0 = [traj_params.X0;0];
mnk_params.nev_threshold = 1;
mnk_params.R_max = 500e3;

X3 = [];
X3_ = [];
z = track.crd(3,1);
for i = 1:length(poits)
    posts = config.posts;
    sigma_xy = 5;
    sigma_z = 10;
    posts(1:2,:) = posts(1:2,:) + normrnd(0, sigma_xy,[2 4]);
    posts(3,:) = posts(3,:) + normrnd(0, sigma_z,[1 4]);
    pd = poits(i).ToA * config.c_ns;
    nms = find(pd);
    posts = posts(:,nms);
    toa = pd(nms);
    [res] = mnk_pdm2D(toa, config.posts(:,nms), z, mnk_params);
    X3(:,i) = res.X;
    [res] = mnk_pdm2D(toa, posts, z, mnk_params);
    X3_(:,i) = res.X;
end
X0 = traj_params.X0;
% X0 = X3(1:2,1);
s_ksi = 1;
h = z;
% track.poits = poits;
% X0 = [track.crd(1,1);track.vel(1,1);track.crd(2,1);track.vel(2,1);track.crd(3,1);track.vel(3,1)];
% X0 = [X3(1,1); 0; X3(2,1); 0; -1000; 0;];
[KFilter] = RDKalmanFilter3D_0_h(track, config, track.crd(1:2,1), eye(2), s_ksi, z);
figure
hold on
grid minor
plot(config.posts(1,:),config.posts(2,:),'vk','linewidth',2)
plot(X3_(1,:),X3_(2,:),'.')
plot(X3(1,:),X3(2,:),'.')
plot(KFilter.crd(1,:),KFilter.crd(2,:),'-')
plot(traj_params.X0(1,1),traj_params.X0(2,1),'pentagram')
[std(X3(1:2,:)')' std(X3_(1:2,:)')' std(X3_(1:2,:)')'./std(X3(1:2,:)')']
figure
subplot(121)
plot(KFilter.crd(1:3,:)'-track.crd(:,1)')
hold on
plot(3*sqrt(KFilter.Dx([1 2],:))')
grid minor
subplot(122)
plot(KFilter.Dx')
grid minor
% [std(KFilter.crd(1:3,:)')' sqrt(KFilter.Dx([1 2],end))]

%%
x3 = [];
x3_ = [];
for j = 1:100
    track = make_measurements_for_track(track, measurements_params, config);
    params.mode = 1;
    params.percentage = [0 0 0];
    params.banned_post = 4;
    [poits, res] = thinning_measurements(track.poits, params, config);
    mnk_params.epsilon = 0.001;
    mnk_params.max_iter = 20;
    mnk_params.X0 = [traj_params.X0;0];
    mnk_params.nev_threshold = 1;
    mnk_params.R_max = 500e3;
    
    X3 = [];
    X3_ = [];
    z = track.crd(3,1);
    for i = 1:length(poits)
        posts = config.posts;
        sigma_xy = 5;
        sigma_z = 10;
        posts(1:2,:) = posts(1:2,:) + normrnd(0, sigma_xy,[2 4]);
        posts(3,:) = posts(3,:) + normrnd(0, sigma_z,[1 4]);
        pd = poits(i).ToA * config.c_ns;
        nms = find(pd);
        posts = posts(:,nms);
        toa = pd(nms);
        [res] = mnk_pdm2D(toa, config.posts(:,nms), z, mnk_params);
        X3(:,i) = res.X;
        [res] = mnk_pdm2D(toa, posts, z, mnk_params);
        X3_(:,i) = res.X;
    end
    x3(:,j) = mean(X3');
    x3_(:,j) = mean(X3_');
end
[std(X3(1:2,:)')' std(X3_(1:2,:)')' std(X3_(1:2,:)')'./std(X3(1:2,:)')']
[std(x3(1:2,:)')' std(x3_(1:2,:)')' std(x3_(1:2,:)')'./std(x3(1:2,:)')']