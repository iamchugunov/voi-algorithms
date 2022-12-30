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
traj_params.kurs = 45;
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
measurements_params.sigma_n_ns = config.sigma_n_ns;
track = make_measurements_for_track(track, measurements_params, config);
for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
end
res1 = nonlinear_approx_rdm(track.poits, config, X0);
[res1.R res1.X res1.X - X0]
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
res2 = nonlinear_approx_rdm(track.poits, config, X0);
[res2.R res2.X res2.X - X0]
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.acc(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.acc(2,1);
    track.crd(3,1);
    track.vel(3,1);
    track.acc(3,1);];
res3 = nonlinear_approx_rdm(track.poits, config, X0);
[res3.R res3.X res3.X - X0]
figure
show_posts2D
hold on
grid minor
show_track2D(track)
set(gca,'FontSize',14)
set(gca,'FontName','Times')
figure
show_posts2D
hold on
grid minor
show_primary_points2D(track.poits)
plot(res1.crd(1,:)/1000,res1.crd(2,:)/1000,'o-','linewidth',2,'MarkerSize',15)
plot(res2.crd(1,:)/1000,res2.crd(2,:)/1000,'v-','linewidth',2,'MarkerSize',10)
plot(res3.crd(1,:)/1000,res3.crd(2,:)/1000,'*-','linewidth',2,'MarkerSize',10)
show_track2D(track)
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('ПП','Первичные точки','Порядок 0','Порядок 1','Порядок 2','Истинная траектория')
%%
% v != const
close all
clear all
config = Config();
traj_params.X0 = [50e3; -50e3];
traj_params.V = 200;
traj_params.kurs = 130;
traj_params.h = 10e3;
traj_params.time_interval = [1 31];
traj_params.track_id = 0;
% traj_params.maneurs = [];
traj_params.maneurs(1) = struct('t0',1,'t',31,'acc',0,'omega',1);
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
measurements_params.sigma_n_ns = config.sigma_n_ns;
track = make_measurements_for_track(track, measurements_params, config);
for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
end
res1 = nonlinear_approx_rdm(track.poits, config, X0);
[res1.R res1.X res1.X - X0]
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
res2 = nonlinear_approx_rdm(track.poits, config, X0);
[res2.R res2.X res2.X - X0]
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.acc(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.acc(2,1);
    track.crd(3,1);
    track.vel(3,1);
    track.acc(3,1);];
res3 = nonlinear_approx_rdm(track.poits, config, X0);
[res3.R res3.X res3.X - X0]
figure
show_posts2D
hold on
grid minor
show_track2D(track)
set(gca,'FontSize',14)
set(gca,'FontName','Times')
figure
show_posts2D
hold on
grid minor
show_primary_points2D(track.poits)
plot(res1.crd(1,:)/1000,res1.crd(2,:)/1000,'o-','linewidth',2,'MarkerSize',15)
plot(res2.crd(1,:)/1000,res2.crd(2,:)/1000,'v-','linewidth',2,'MarkerSize',10)
plot(res3.crd(1,:)/1000,res3.crd(2,:)/1000,'*-','linewidth',2,'MarkerSize',10)
show_track2D(track)
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('ПП','Первичные точки','Порядок 0','Порядок 1','Порядок 2','Истинная траектория')
%% II
% v != const
close all
clear all
config = Config();
traj_params.X0 = [50e3; -50e3];
traj_params.V = 200;
traj_params.kurs = 45;
traj_params.h = 10e3;
traj_params.time_interval = [1 31];
traj_params.track_id = 0;
traj_params.maneurs = [];
% traj_params.maneurs(1) = struct('t0',1,'t',31,'acc',0,'omega',1);
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
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
measurements_params.sigma_n_ns = config.sigma_n_ns * 0;
measurements_params.period_sec = 0.1;
track = make_measurements_for_track(track, measurements_params, config);
res1 = nonlinear_approx_rdm(track.poits, config, X0);
res2 = nonlinear_approx_rdm(track.poits(1:150), config, X0);
measurements_params.period_sec = 0.2;
track = make_measurements_for_track(track, measurements_params, config);
res3 = nonlinear_approx_rdm(track.poits, config, X0);
res = [res1.R res2.R res3.R]
%%
% v != const krutim
close all
clear all
config = Config();

kurs = 0:10:350;
R = [];
for i = 1:length(kurs)
    traj_params.X0 = [50e3; -50e3*0];
    traj_params.V = 200;
    traj_params.kurs = kurs(i);
    traj_params.h = 10e3;
    traj_params.time_interval = [1 31];
    traj_params.track_id = 0;
    traj_params.maneurs = [];
    track = make_geo_track_new(traj_params, config);
    config.sigma_n_ns = 10;
    measurements_params.sigma_n_ns = config.sigma_n_ns*0;
    measurements_params.period_sec = 0.2;
    measurements_params.n_periods = 0;
    measurements_params.strob_dur = 0.12;
    measurements_params.s_ksi = 0;
    track = make_measurements_for_track(track, measurements_params, config);
    X0 = [track.crd(1,1);
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
    res = nonlinear_approx_rdm(track.poits, config, X0);
    R(:,i) = res.R;
    i
end
%%
%%
% T_nak = const, N points var = 30:500
close all
clear all
config = Config();
N = 30:10:500;
time_interval = [1 16; 1 31; 1 46; 1 61];
R = {};
for j = 1:size(time_interval,1)
    for i = 1:length(N)
        traj_params.X0 = [50e3; -50e3];
        traj_params.V = 200;
%         traj_params.kurs = 130;
        traj_params.kurs = 45;
        traj_params.h = 10e3;
        traj_params.time_interval = time_interval(j,:);
        traj_params.track_id = 0;
        traj_params.maneurs = [];
        track = make_geo_track_new(traj_params, config);
        config.sigma_n_ns = 10;
        measurements_params.sigma_n_ns = config.sigma_n_ns*0;
        measurements_params.period_sec = diff(traj_params.time_interval)/N(i);
        measurements_params.n_periods = 0;
        measurements_params.strob_dur = 0.12;
        measurements_params.s_ksi = 0;
        track = make_measurements_for_track(track, measurements_params, config);
        X0 = [track.crd(1,1);
        track.vel(1,1);
        track.crd(2,1);
        track.vel(2,1);
        track.crd(3,1);
        track.vel(3,1);];
        res = nonlinear_approx_rdm(track.poits, config, X0);
        R{j}(:,i) = res.R;
        [j i]
    end
end
%%
figure(1)
plot(N,R{1}(1,:),'linewidth',2)
hold on
grid minor
plot(N,R{2}(1,:),'linewidth',2)
plot(N,R{3}(1,:),'linewidth',2)
plot(N,R{4}(1,:),'linewidth',2)
xlabel("Количество отметок")
ylabel("R_x, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('Т_{нак} = 15 сек','Т_{нак} = 30 сек','Т_{нак} = 45 сек','Т_{нак} = 60 сек')

figure(2)
plot(N,R{1}(2,:),'linewidth',2)
hold on
grid minor
plot(N,R{2}(2,:),'linewidth',2)
plot(N,R{3}(2,:),'linewidth',2)
plot(N,R{4}(2,:),'linewidth',2)
xlabel("Количество отметок")
ylabel("R_{v_x}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('Т_{нак} = 15 сек','Т_{нак} = 30 сек','Т_{нак} = 45 сек','Т_{нак} = 60 сек')

figure(3)
plot(N,R{1}(3,:),'linewidth',2)
hold on
grid minor
plot(N,R{2}(3,:),'linewidth',2)
plot(N,R{3}(3,:),'linewidth',2)
plot(N,R{4}(3,:),'linewidth',2)
xlabel("Количество отметок")
ylabel("R_y, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('Т_{нак} = 15 сек','Т_{нак} = 30 сек','Т_{нак} = 45 сек','Т_{нак} = 60 сек')

figure(4)
plot(N,R{1}(4,:),'linewidth',2)
hold on
grid minor
plot(N,R{2}(4,:),'linewidth',2)
plot(N,R{3}(4,:),'linewidth',2)
plot(N,R{4}(4,:),'linewidth',2)
xlabel("Количество отметок")
ylabel("R_{v_y}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('Т_{нак} = 15 сек','Т_{нак} = 30 сек','Т_{нак} = 45 сек','Т_{нак} = 60 сек')
%%
% T_nak = const, N points var = 30:500
close all
clear all
config = Config();

time_interval = [ones(26,1) (10:2:60)'];
N = [50 100 200 300];
R = {};
for j = 1:length(N)
    for i = 1:size(time_interval,1)
        traj_params.X0 = [50e3; -50e3];
        traj_params.V = 200;
%         traj_params.kurs = 130;
        traj_params.kurs = 45;
        traj_params.h = 10e3;
        traj_params.time_interval = time_interval(i,:);
        traj_params.track_id = 0;
        traj_params.maneurs = [];
        track = make_geo_track_new(traj_params, config);
        config.sigma_n_ns = 10;
        measurements_params.sigma_n_ns = config.sigma_n_ns*0;
        measurements_params.period_sec = diff(traj_params.time_interval)/N(j);
        measurements_params.n_periods = 0;
        measurements_params.strob_dur = 0.12;
        measurements_params.s_ksi = 0;
        track = make_measurements_for_track(track, measurements_params, config);
        X0 = [track.crd(1,1);
        track.vel(1,1);
        track.crd(2,1);
        track.vel(2,1);
        track.crd(3,1);
        track.vel(3,1);];
        res = nonlinear_approx_rdm(track.poits, config, X0);
        R{j}(:,i) = res.R;
        [j i]
    end
end
%%
figure(1)
plot(time_interval(:,2),R{1}(1,:),'linewidth',2)
hold on
grid minor
plot(time_interval(:,2),R{2}(1,:),'linewidth',2)
plot(time_interval(:,2),R{3}(1,:),'linewidth',2)
plot(time_interval(:,2),R{4}(1,:),'linewidth',2)
xlabel("Т_{нак}, сек")
ylabel("R_x, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(2)
plot(time_interval(:,2),R{1}(2,:),'linewidth',2)
hold on
grid minor
plot(time_interval(:,2),R{2}(2,:),'linewidth',2)
plot(time_interval(:,2),R{3}(2,:),'linewidth',2)
plot(time_interval(:,2),R{4}(2,:),'linewidth',2)
xlabel("Т_{нак}, сек")
ylabel("R_{v_x}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(3)
plot(time_interval(:,2),R{1}(3,:),'linewidth',2)
hold on
grid minor
plot(time_interval(:,2),R{2}(3,:),'linewidth',2)
plot(time_interval(:,2),R{3}(3,:),'linewidth',2)
plot(time_interval(:,2),R{4}(3,:),'linewidth',2)
xlabel("Т_{нак}, сек")
ylabel("R_y, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(4)
plot(time_interval(:,2),R{1}(4,:),'linewidth',2)
hold on
grid minor
plot(time_interval(:,2),R{2}(4,:),'linewidth',2)
plot(time_interval(:,2),R{3}(4,:),'linewidth',2)
plot(time_interval(:,2),R{4}(4,:),'linewidth',2)
xlabel("Т_{нак}, сек")
ylabel("R_{v_y}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('50 отметок','100 отметок','200 отметок','300 отметок')
%% troiki
% T_nak = const, N points var = 30:500
close all
clear all
config = Config();

traj_params.X0 = [50e3; -50e3];
    traj_params.V = 200;
    traj_params.kurs = 130;
%     traj_params.kurs = 45;
    traj_params.h = 10e3;
    traj_params.time_interval = [1 31];
    traj_params.track_id = 0;
    traj_params.maneurs = [];
    track = make_geo_track_new(traj_params, config);
    config.sigma_n_ns = 10;
    measurements_params.sigma_n_ns = config.sigma_n_ns*0;
    measurements_params.period_sec = 0.05;
    measurements_params.n_periods = 0;
    measurements_params.strob_dur = 0.12;
    measurements_params.s_ksi = 0;
    track = make_measurements_for_track(track, measurements_params, config);
    X0 = [track.crd(1,1);
        track.vel(1,1);
        track.crd(2,1);
        track.vel(2,1);
        track.crd(3,1);
        track.vel(3,1);];
per3 = 0:5:100;
per = [];
for i = 1:length(per3)
    per(i,:) = [0 per3(i)/100 0];
end
R = [];
per1 = [];
for i = 1:length(per3)
    params.mode = 0;
    params.percentage = per(i,:);
    params.banned_post = 1;
    [poits, res] = thinning_measurements(track.poits, params, config);
    per1(i,:) = res.percentage;
    res = nonlinear_approx_rdm(poits, config, X0);
    R(:,i) = res.R;  
    i
end
%%
figure(1)
plot(per(:,2),R(1,:),'linewidth',2)
hold on
grid minor
xlabel("Процент 'троек', %")
ylabel("R_x, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(2)
plot(per(:,2),R(2,:),'linewidth',2)
hold on
grid minor
xlabel("Процент 'троек', %")
ylabel("R_{v_x}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(3)
plot(per(:,2),R(3,:),'linewidth',2)
hold on
grid minor
xlabel("Процент 'троек', %")
ylabel("R_y, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(4)
plot(per(:,2),R(4,:),'linewidth',2)
hold on
grid minor
xlabel("Процент 'троек', %")
ylabel("R_{v_y}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')