%%
% test old
close all
clear all
config = Config();
traj_params.X0 = [90e3; -30e3];
traj_params.V = 200;
traj_params.kurs = 163;
traj_params.h = 10e3;
traj_params.time_interval = [1 400];
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
%%
Vp = [];
for i = 1:length(track.poits)
    Vp(:,i) = track.poits(i).true_vel;
    Ap(:,i) = track.poits(i).true_acc;
    track.poits(i) = crd_calc(track.poits(i),config);
    dop_p(:,i) = [track.poits(i).res.dop.XDOP;track.poits(i).res.dop.YDOP;];
end
%2D
figure
subplot(231)
show_posts2D
show_track2D(track)
daspect([1 1 1])
subplot(234)
plot([track.poits.Frame],dop_p','.-r')
hold on
plot(track.t,[track.dop.XDOP],'.-b')
plot(track.t,[track.dop.YDOP],'.-b')
subplot(232)
plot(track.t,track.vel(1,:),'o-r')
hold on
plot([track.poits.Frame],Vp(1,:),'.-b')
subplot(235)
plot(track.t,track.vel(2,:),'o-r')
hold on
plot([track.poits.Frame],Vp(2,:),'.-b')
subplot(233)
plot(track.t,track.acc(1,:),'o-r')
hold on
plot([track.poits.Frame],Ap(1,:),'.-b')
subplot(236)
plot(track.t,track.acc(2,:),'o-r')
hold on
plot([track.poits.Frame],Ap(2,:),'.-b')

% X0 = [track.crd(1,1);
%     track.vel(1,1);
%     track.acc(1,1);
%     track.crd(2,1);
%     track.vel(2,1);
%     track.acc(2,1);
%     track.crd(3,1);
%     track.vel(3,1);
%     track.acc(3,1);];
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
params.mode = 0;
params.percentage = [0 1 0.5];
params.banned_post = 1;
poits = thinning_measurements(track.poits, params, config);
res = nonlinear_approx_rdm(track.poits, config, X0);
[X0 res.X res.R]
%% proverka
N = 100;
  for i = 1:N
      i
  track = make_measurements_for_track(track, measurements_params, config);
  X0([1 3 5],1) = track.crd(:,1);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,1);% + normrnd(0, 10, [3 1]);
 
  res = nonlinear_approx_rdm(track.poits(1:300), config, X0);
  X(:,i) = res.X;
  R(:,i) = res.R;
  end
 [mean(R')' std(X')']
%% nakoplenie

t2 = [100 150 200 250 300 350 400 450];
% R = 90 km;
t1 = 240;
for i = 1:length(t2)
      i
 
  X0([1 3 5],1) = track.crd(:,t1/10);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,t1/10);% + normrnd(0, 10, [3 1]);
 
  res = nonlinear_approx_rdm(track.poits(t1:t1+t2(i)), config, X0);
  X90(:,i) = res.X;
  R90(:,i) = res.R;
end
RMS = [];
for i = 1:length(R90)
    RMS(1,i) = norm(R90([1 3],i));
end
DOP(1) = track.dop(t1/10).HDOP;
% R = 75 km;
t1 = 1000;
for i = 1:length(t2)
      i
 
  X0([1 3 5],1) = track.crd(:,t1/10);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,t1/10);% + normrnd(0, 10, [3 1]);
 
  res = nonlinear_approx_rdm(track.poits(t1:t1+t2(i)), config, X0);
  X75(:,i) = res.X;
  R75(:,i) = res.R;
end
for i = 1:length(R75)
    RMS(2,i) = norm(R75([1 3],i));
end
DOP(2) = track.dop(t1/10).HDOP;
% R = 60 km;
t1 = 1720;
for i = 1:length(t2)
      i
 
  X0([1 3 5],1) = track.crd(:,t1/10);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,t1/10);% + normrnd(0, 10, [3 1]);
 
  res = nonlinear_approx_rdm(track.poits(t1:t1+t2(i)), config, X0);
  X60(:,i) = res.X;
  R60(:,i) = res.R;
end
for i = 1:length(R60)
    RMS(3,i) = norm(R60([1 3],i));
end
DOP(3) = track.dop(t1/10).HDOP;
% R = 45 km;
t1 = 2480;
for i = 1:length(t2)
      i
 
  X0([1 3 5],1) = track.crd(:,t1/10);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,t1/10);% + normrnd(0, 10, [3 1]);
 
  res = nonlinear_approx_rdm(track.poits(t1:t1+t2(i)), config, X0);
  X45(:,i) = res.X;
  R45(:,i) = res.R;
end
for i = 1:length(R45)
    RMS(4,i) = norm(R45([1 3],i));
end
DOP(4) = track.dop(t1/10).HDOP;
% R = 30 km;
t1 = 3250;
for i = 1:length(t2)
      i
 
  X0([1 3 5],1) = track.crd(:,t1/10);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,t1/10);% + normrnd(0, 10, [3 1]);
 
  res = nonlinear_approx_rdm(track.poits(t1:t1+t2(i)), config, X0);
  X30(:,i) = res.X;
  R30(:,i) = res.R;
end
for i = 1:length(R30)
    RMS(5,i) = norm(R30([1 3],i));
end
DOP(5) = track.dop(t1/10).HDOP;

plot(t2/10,RMS,'linewidth',2)
grid on
grid on
hold on
xlabel('T_{ac}, sec')
ylabel('RMS, m')
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('R = 90 km, HDOP = 349','R = 75 km, HDOP = 237','R = 60 km, HDOP = 151','R = 45 km, HDOP = 81','R = 30 km, HDOP = 33')
%% nepolnie 3
per(1,:) = [0 0 1];
per(2,:) = [0 0.1 1];
per(3,:) = [0 0.2 1];
per(4,:) = [0 0.3 1];
per(5,:) = [0 0.4 1];
per(6,:) = [0 0.5 1];
per(7,:) = [0 0.6 1];
per(8,:) = [0 0.7 1];
per(9,:) = [0 0.8 1];
per(10,:) = [0 0.9 1];
per(11,:) = [0 1 0];
  for i = 1:length(per)
      i
      params.mode = 0;
    params.percentage = per(i,:);
    params.banned_post = 1;
  [poits, res] = thinning_measurements(track.poits(1:300), params, config);
  X0([1 3 5],1) = track.crd(:,1);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,1);% + normrnd(0, 10, [3 1]);
 per(i,:) = res.percentage;
  res = nonlinear_approx_rdm(poits, config, X0);
  Xt(:,i) = res.X;
  Rt(:,i) = res.R;
  end
RMSt = [];
for i = 1:length(Rt)
    RMSt(i) = norm(Rt([1 3],i));
end
plot(per(:,2),RMSt,'linewidth',2)
grid on
grid on
hold on
xlabel('"Threes" percentage, %')
ylabel('RMS, m')
set(gca,'FontSize',14)
set(gca,'FontName','Times')
%%
%% nepolnie dvoik
per(1,:) = [0 1 0];
per(2,:) = [0.1 0.9 0];
per(3,:) = [0.2 0.8 0];
per(4,:) = [0.3 0.7 0];
per(5,:) = [0.4 0.6 0];
per(6,:) = [0.5 0.5 0];
per(7,:) = [0.6 0.4 0];
per(8,:) = [0.7 0.3 0];
per(9,:) = [0.8 0.2 0];
per(10,:) = [0.9 0.1 0];
per(11,:) = [1 0 0];
  for i = 1:length(per)
      i
      params.mode = 0;
    params.percentage = per(i,:);
    params.banned_post = 1;
  [poits, res] = thinning_measurements(track.poits(1:300), params, config);
  X0([1 3 5],1) = track.crd(:,1);% + normrnd(0, 1000, [3 1]);
  X0([2 4 6],1) = track.vel(:,1);% + normrnd(0, 10, [3 1]);
 per(i,:) = res.percentage;
  res = nonlinear_approx_rdm(poits, config, X0);
  Xt(:,i) = res.X;
  Rt(:,i) = res.R;
  end
RMSt = [];
for i = 1:length(Rt)
    RMSt(i) = norm(Rt([1 3],i));
end
plot(per(:,1),RMSt,'linewidth',2)
grid on
grid on
hold on
xlabel('"Twos" percentage, %')
ylabel('RMS, m')
set(gca,'FontSize',14)
set(gca,'FontName','Times')
%%
config.sigma_n_ns = 10;
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
%   figure
%   get_rd_from_poits(track.poits)
params.mode = 0;
params.percentage = [0 0.5 0.5];
params.banned_post = 1;
poits1 = thinning_measurements(track.poits, params, config);
params.percentage = [0 1 0];
poits2 = thinning_measurements(track.poits, params, config);
params.percentage = [0.5 0.4 0.1];
poits3 = thinning_measurements(track.poits, params, config);
params.percentage = [1 0 0];
poits4 = thinning_measurements(track.poits, params, config);

X0 = [track.crd(1,1);
    track.crd(2,1);
    track.crd(3,1);];
res = nonlinear_approx_rdm(track.poits, config, X0);
res1 = nonlinear_approx_rdm(poits1, config, X0);
res2 = nonlinear_approx_rdm(poits2, config, X0);
res3 = nonlinear_approx_rdm(poits3, config, X0);
res4 = nonlinear_approx_rdm(poits4, config, X0);
fprintf("1 order\n")
for i = 1:length(X0)
    fprintf("%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\n",X0(i),res.X(i),res.R(i),res1.X(i),res1.R(i),res2.X(i),res2.R(i),res3.X(i),res3.R(i),res4.X(i),res4.R(i))
end
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.crd(3,1);
    track.vel(3,1);];
res = nonlinear_approx_rdm(track.poits, config, X0);
res1 = nonlinear_approx_rdm(poits1, config, X0);
res2 = nonlinear_approx_rdm(poits2, config, X0);
res3 = nonlinear_approx_rdm(poits3, config, X0);
res4 = nonlinear_approx_rdm(poits4, config, X0);
fprintf("2 order\n")
for i = 1:length(X0)
    fprintf("%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\n",X0(i),res.X(i),res.R(i),res1.X(i),res1.R(i),res2.X(i),res2.R(i),res3.X(i),res3.R(i),res4.X(i),res4.R(i))
end
X0 = [track.crd(1,1);
    track.vel(1,1);
    track.acc(1,1);
    track.crd(2,1);
    track.vel(2,1);
    track.acc(2,1);
    track.crd(3,1);
    track.vel(3,1);
    track.acc(3,1);];
res = nonlinear_approx_rdm(track.poits, config, X0);
res1 = nonlinear_approx_rdm(poits1, config, X0);
res2 = nonlinear_approx_rdm(poits2, config, X0);
res3 = nonlinear_approx_rdm(poits3, config, X0);
res4 = nonlinear_approx_rdm(poits4, config, X0);
fprintf("3 order\n")
for i = 1:length(X0)
    fprintf("%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\t%10.1f\n",X0(i),res.X(i),res.R(i),res1.X(i),res1.R(i),res2.X(i),res2.R(i),res3.X(i),res3.R(i),res4.X(i),res4.R(i))
end
  %%