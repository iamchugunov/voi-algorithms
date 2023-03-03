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
    while abs(per(i,2) - res.percentage(2)/100) > 0.001
        disp("try")
        [poits, res] = thinning_measurements(track.poits, params, config);
    end
    per1(i,:) = res.percentage;
    res = nonlinear_approx_rdm(poits, config, X0);
    R(:,i) = res.R;  
    i
end
%%
figure(1)
plot(per1(:,2),R(1,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "троек", %')
ylabel("R_x, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(2)
plot(per1(:,2),R(2,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "троек", %')
ylabel("R_{v_x}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(3)
plot(per1(:,2),R(3,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "троек", %')
ylabel("R_y, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(4)
plot(per1(:,2),R(4,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "троек", %')
ylabel("R_{v_y}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')
%% dvoiki
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
    per(i,:) = [per3(i)/100 1-per3(i)/100  0];
end
R = [];
per1 = [];
for i = 1:length(per3)
    params.mode = 0;
    params.percentage = per(i,:);
    params.banned_post = 1;
    [poits, res] = thinning_measurements(track.poits, params, config);
    while abs(per(i,1) - res.percentage(1)/100) > 0.001
        disp("try")
        [poits, res] = thinning_measurements(track.poits, params, config);
    end
    per1(i,:) = res.percentage;
    res = nonlinear_approx_rdm(poits, config, X0);
    R(:,i) = res.R;  
    i
end
%%
figure(1)
plot(per1(:,1),R(1,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "двоек", %')
ylabel("R_x, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(2)
plot(per1(:,1),R(2,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "двоек", %')
ylabel("R_{v_x}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(3)
plot(per1(:,1),R(3,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "двоек", %')
ylabel("R_y, м")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')

figure(4)
plot(per1(:,1),R(4,:),'linewidth',2)
hold on
grid minor
xlabel('Процент "двоек", %')
ylabel("R_{v_y}, м/с")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
% legend('50 отметок','100 отметок','200 отметок','300 отметок')
%% initial
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
    measurements_params.sigma_n_ns = config.sigma_n_ns;
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
        track.vel(3,1)];
%%
% v = true, crds - var
X = [];
for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i), config);
    X0 = [track.poits(i).est_crd(1);
        track.vel(1,1);
        track.poits(i).est_crd(2);
        track.vel(2,1);
        track.poits(i).est_crd(3);
        track.vel(3,1)];
    res = nonlinear_approx_rdm(track.poits, config, X0);
    [X0 res.X]
    X(:,i) = res.X;
end
%%
% v = var, crds - true
V = 200;
alpha = [0:5:360]*pi/180;
X = [];
x0 = [];
for i = 1:length(alpha)
    X0 = [track.crd(1,1);
        V*cos(alpha(i));
        track.crd(2,1);
        V*sin(alpha(i));
        track.crd(3,1);
        0];
    res = nonlinear_approx_rdm(track.poits, config, X0);
    [X0 res.X]
    X(:,i) = res.X;
    x0(:,i) = X0;
end
%% sravnenie s lineinoi
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
    measurements_params.sigma_n_ns = config.sigma_n_ns;
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
        track.vel(3,1)];
    
%%
measurements_params.sigma_n_ns = config.sigma_n_ns;
for i = 1:1000
    track = make_measurements_for_track(track, measurements_params, config);
    [SV] = group_calc(track.poits, config);
    sv(:,i) = SV.sv;
end
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
        track.vel(3,1)];
    
    res1 = nonlinear_approx_rdm(track.poits, config, X0);
    res2 = nonlinear_approx_rdm(track.poits, config, sv(:,1));
    [std(sv')' res1.R res2.R]
    %% non full
    measurements_params.sigma_n_ns = config.sigma_n_ns;
for i = 1:100
    track = make_measurements_for_track(track, measurements_params, config);
    params.mode = 0;
    params.percentage = [0 0.5 0.5];
    params.banned_post = 1;
    [poits, res] = thinning_measurements(track.poits, params, config);
    nums = find([poits.count] == 4);
    [SV] = group_calc(poits(nums), config);
    sv(:,i) = SV.sv;
end
measurements_params.sigma_n_ns = config.sigma_n_ns*0;
    measurements_params.period_sec = 0.2;
    measurements_params.n_periods = 0;
    measurements_params.strob_dur = 0.12;
    measurements_params.s_ksi = 0;
    track = make_measurements_for_track(track, measurements_params, config);
    params.mode = 0;
    params.percentage = [0 0.5 0.5];
    params.banned_post = 1;
    [poits, res] = thinning_measurements(track.poits, params, config);
X0 = [track.crd(1,1);
        track.vel(1,1);
        track.crd(2,1);
        track.vel(2,1);
        track.crd(3,1);
        track.vel(3,1)];
    
    res1 = nonlinear_approx_rdm(poits, config, X0);
    res2 = nonlinear_approx_rdm(poits, config, sv(:,1));
    [std(sv')' res1.R res2.R]
%% non full vliyanie nepolnih
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
    measurements_params.period_sec = 0.1;
    measurements_params.n_periods = 0;
    measurements_params.strob_dur = 0.12;
    measurements_params.s_ksi = 0;
    track = make_measurements_for_track(track, measurements_params, config);
    X0 = [track.crd(1,1);
        track.vel(1,1);
        track.crd(2,1);
        track.vel(2,1);
        track.crd(3,1);
        track.vel(3,1)];
    %%
params.mode = 0;
    params.percentage = [0.95 0.0 0.1];
    params.banned_post = 1;
    [poits, res] = thinning_measurements(track.poits, params, config);
    nms = find([poits.count] == 4);
    poits1 = poits(nms);
    res1 = nonlinear_approx_rdm(poits, config, X0);
    res2 = nonlinear_approx_rdm(poits1, config, X0);
%%
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
R1 = [];
R2 = [];
per1 = [];
for i = 1:length(per3)
    params.mode = 0;
    params.percentage = per(i,:);
    params.banned_post = 1;
    [poits, res] = thinning_measurements(track.poits, params, config);
    while abs(per(i,2) - res.percentage(2)/100) > 0.001
        disp("try")
        [poits, res] = thinning_measurements(track.poits, params, config);
    end
    per1(i,:) = res.percentage;
    res = nonlinear_approx_rdm(poits, config, X0);
    R1(:,i) = res.R;
    nms = find([poits.count] == 4);
    res = nonlinear_approx_rdm(poits(nms), config, X0);
    R2(:,i) = res.R;  
    i
end
%%
figure(1)
rat = R2./R1;
plot(per(1:end-1,2)*100,rat(1:4,:)','linewidth',2)
hold on
grid minor
xlabel('Процент "троек", %')
ylabel("Выигрыш")
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('x','vx','y','vy')

%% real log test 
clear all
close all
config = Config();
out = readtracefile();
%%
poits = out.poits;
t0 = poits(1).Frame;
for i = 1:length(poits)
    poits(i).Frame = poits(i).Frame - t0;
end
%%
t0 = t0 + 180;
T_nak = 30;
n1 = find([poits.Frame] >= t0);
n1 = n1(1);
n2 = find([poits.Frame] < (t0 + T_nak));
n2 = n2(end);
poits1 = poits(n1:n2);
X0 = [];
k = 0;
for i = 1:length(poits1)
    if poits1(i).count == 4
        poits1(i) = crd_calc(poits1(i),config);
        if poits1(i).crd_valid
            k = k + 1;
            X0(:,k) = poits1(i).est_crd;
        end
    end
end
[SV] = group_calc(poits1, config);
show_posts2D
plot(X0(1,:)/1000,X0(2,:)/1000,'.')
plot(mean(X0(1,:))/1000,mean(X0(2,:))/1000,'x')
res = nonlinear_approx_rdm(poits1, config, mean(X0')');
plot(res.crd(1,:)/1000,res.crd(2,:)/1000,'o')
plot(SV.crd(1,:)/1000,SV.crd(2,:)/1000,'.-')
res = nonlinear_approx_rdm(poits1, config, SV.sv);
plot(res.crd(1,:)/1000,res.crd(2,:)/1000,'.-k')
%%
T = 0:30:900;
T = 0:30:2100;
data = {};
for j = 1:length(T)
    j
    t0 = poits(1).Frame;
    t0 = t0 + T(j);
    T_nak = 30;
    n1 = find([poits.Frame] >= t0);
    n1 = n1(1);
    n2 = find([poits.Frame] < (t0 + T_nak));
    n2 = n2(end);
    poits1 = poits(n1:n2);
    X0 = [];
    k = 0;
    toa = [];
    for i = 1:length(poits1)
        toa(:,i) = poits1(i).ToA;
        if poits1(i).count == 4
            poits1(i) = crd_calc(poits1(i),config);
            if poits1(i).crd_valid
                k = k + 1;
                X0(:,k) = poits1(i).est_crd;
            end
        end
    end
    data{j,1} = poits1;
    data{j,4} = length(poits1);
    data{j,5} = [round(length(find([poits1.count] == 2))*100/length(poits1)) round(length(find([poits1.count] == 3))*100/length(poits1)) round(length(find([poits1.count] == 4))*100/length(poits1)) ];
    data{j,6} = [round(length(find(toa(1,:)))*100/length(poits1)) round(length(find(toa(2,:)))*100/length(poits1)) round(length(find(toa(3,:)))*100/length(poits1)) round(length(find(toa(4,:)))*100/length(poits1)) ];
    
    try
        [SV] = group_calc(poits1, config);
        data{j,2} = SV;
        X0 = SV.sv;
    catch
        data{j,2} = [];
        x0 = data{j-1,3}.crd(:,end);
        v0 = data{j-1,3}.X([2 4 6]);
        X0 = [x0(1);v0(1);x0(2);v0(2);x0(3);v0(3)];        
    end
    res = nonlinear_approx_rdm(poits1, config, X0);
    data{j,3} = res;
    
end
%%
show_posts2D

for i = 1:length(poits)
        if poits(i).count == 4
            poits(i) = crd_calc(poits(i),config);
        end
end

show_primary_points2D(poits)
for i = 1:76
    if ~isempty(data{i,3})
        if data{i,3}.norm_nev(end) < 100
            crd = data{i,3}.crd;
            plot(crd(1,:)/1000,crd(2,:)/1000,'.-k')
            text(crd(1,1)/1000 ,crd(2,1)/1000,num2str(i),'FontName','Times','FontSize',14)
        end
    end
    if ~isempty(data{i,2})
        sv = data{i,2}.crd;
        plot(sv(1,:)/1000,sv(2,:)/1000,'.-r')
        text(sv(1,1)/1000,sv(2,1)/1000,num2str(i),'Color','red')
    end
end
set(gca,'FontName','Times')
set(gca,'FontSize',14)
grid minor
daspect auto
figure
get_rd_from_poits(poits(1:8000))
%%
k = 0;
X = [];
R = [];
t = [];
per3 = [];
per4 = [];
count = [];
k1 = 0;
for i = 1:71
    k = k + 1;
    if ~isempty(data{i,3})
        if data{i,3}.norm_nev(end) < 100
            k1 = k1 + 1;
            X(:,k1) = data{i,3}.X;
            R(:,k1) = data{i,3}.R;
            t(k1) = T(i);
        end
    end
    per3(:,k) = data{i,5}';
    per4(:,k) = data{i,6}';
    count(:,k) = data{i,4}';
end
close all
figure
plot(T,per3')
xlabel('t, сек')
ylabel('%')
set(gca,'FontName','Times')
set(gca,'FontSize',14)
grid minor
legend('"двойки"','"тройки"','"четверки"')
figure
plot(T,per4')
xlabel('t, сек')
ylabel('%')
set(gca,'FontName','Times')
set(gca,'FontSize',14)
grid minor
legend('ПП№1','ПП№2','ПП№3','ПП№4')
figure
show_posts2D
grid minor
plot(X(1,:)/1000,X(3,:)/1000,'.-')
text(X(1,:)/1000,X(3,:)/1000,num2str(t'))