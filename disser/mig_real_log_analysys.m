[real_track] = read_gpx_file();
[tracks] = readtracefolder();
config = Config('iran2809');
%% sovmeshenie po vremeni
% get_rd_from_poits(tracks(1).poits)
% figure
% plot(real_track.t,real_track.rd','.')

k = 0;
poits = [tracks(1).poits];

% TOA CORRECTION
delta = [-84 -70 -99];
for i = 1:length(poits)
    for j = 1:3
        if poits(i).ToA(j)
            poits(i).ToA(j) = poits(i).ToA(j) + delta(j)/config.c_ns;
        end
    end
end

for i = 1:length(poits)
    poit = poits(i);
    toa = poit.ToA;
    poit.rd = [0;0;0;0;0;0];
    poit.rd_flag = [0;0;0;0;0;0];
    if (toa(4) > 0 && toa(1) > 0)
        poit.rd(1) = (toa(4) - toa(1))*config.c_ns;
        poit.rd_flag(1) = 1;
    end
    if (toa(4) > 0 && toa(2) > 0)
        poit.rd(2) = (toa(4) - toa(2))*config.c_ns;
        poit.rd_flag(2) = 1;
    end
    if (toa(4) > 0 && toa(3) > 0)
        poit.rd(3) = (toa(4) - toa(3))*config.c_ns;
        poit.rd_flag(3) = 1;
    end
    if (toa(3) > 0 && toa(1) > 0)
        poit.rd(4) = (toa(3) - toa(1))*config.c_ns;
        poit.rd_flag(4) = 1;
    end
    if (toa(3) > 0 && toa(2) > 0)
        poit.rd(5) = (toa(3) - toa(2))*config.c_ns;
        poit.rd_flag(5) = 1;
    end
    if (toa(2) > 0 && toa(1) > 0)
        poit.rd(6) = (toa(2) - toa(1))*config.c_ns;
        poit.rd_flag(6) = 1;
    end
    poits(i) = poit;
end
% TOA CORRECTION END

for i = 1:length(poits)
        rd(i) = poits(i).rd(1);
end
[~, num] = max(rd);
t0_tracks = poits(num).Frame;

for i = 1:length(poits)
    poits(i).Frame = poits(i).Frame - t0_tracks;
end

[~,num] = max(real_track.rd(1,:));

t0_real = real_track.t(num) - 2.2; % SDVIG PRI KOTOROM MAXIMALNAYA KORRELATCIYA -2.2
t = real_track.t - t0_real;

t0 = -30;
t_end = poits(end).Frame;

nms = find([poits.Frame] > t0);
cur_poits = poits(nms);
nms = find([cur_poits.Frame] < t_end);
cur_poits = cur_poits(nms);

nms = find(t > t0);
t = t(nms);
crd = real_track.crd(:,nms);
vel = real_track.vel(:,nms);
acc = real_track.acc(:,nms);
rd_real = real_track.rd(:,nms);
pos = real_track.pos(:,nms);
nms = find(t < t_end);
t = t(nms);
crd = crd(:,nms);
vel = real_track.vel(:,nms);
acc = real_track.acc(:,nms);
rd_real = rd_real(:,nms);
pos = pos(:,nms);

real_track_new.crd = crd;
real_track_new.vel = vel;
real_track_new.t = t;
real_track_new.acc = acc;
real_track_new.rd = rd_real;
real_track_new.pos = pos;

tt = {};
err = {};
RD = {};
for i = 1:6
    cur_rd = [];
    cur_t = [];
    k = 0;
    for j = 1:length(cur_poits)
        if cur_poits(j).rd_flag(i)
            k = k + 1;
            tt{i}(k) = cur_poits(j).Frame;
            RD{i}(k) = cur_poits(j).rd(i);
        end
    end
    rd_real_cur = interp1(t, rd_real(i,:), tt{i});
    err{i} = RD{i} - rd_real_cur;
end

figure
plot(t,rd_real/1000,'.-')
get_rd_from_poits(cur_poits)
% axis([-40 60 16 28])
figure
hold on
ylim([-200 200])
for i = 1:6
    plot(tt{i},err{i},'.')
end

figure
hold on
for i = 1:6
    histogram(err{i})
end

figure
plot(crd(1,:),crd(2,:),'.-')
%% poits analysys
%% hgeo decode
k = 0;
th = [];
h_geo = [];
for i = 1:length(cur_poits)
    code = decodeACcode(dec2hex(cur_poits(i).ACdata,4));
    if code ~= -1000 && code > 1000 && code < 15000
        k = k + 1;
        th(k) = cur_poits(i).Frame;
        h_geo(k) = code;
    end
end
nums = find(abs(diff(h_geo)) > 35);
h_geo(nums) = [];
th(nums) = [];
nums = find(abs(diff(h_geo)) > 35);
h_geo(nums) = [];
th(nums) = [];
plot(real_track_new.t,real_track_new.pos(3,:),'linewidth',2)
grid minor
hold on
plot(th, h_geo + 470,'linewidth',2)
set(gca,'FontSize',18)
set(gca,'FontName','Times')
xlabel('t, сек')
ylabel('h, м')
legend('Референс','A/C режим')
xlim([0 1400])
ylim([7200 8400])
%%
poits_analysis(cur_poits)
%% give poits h_geo
DELTA = 470;
for i = 1:length(cur_poits)
    nms = find(th >= cur_poits(i).Frame);
    if ~isempty(nms)
        cur_poits(i).h_geo = h_geo(nms(1))+DELTA;
    else
        cur_poits(i).h_geo = h_geo(end)+DELTA;
    end
end
%%
close all
for i = 1:length(cur_poits)
    if cur_poits(i).count == 4
        cur_poits(i) = crd_calc(cur_poits(i),config);
    end
end
for i = 1:length(cur_poits)
    if cur_poits(i).crd_valid
        crd0 = cur_poits(i).est_crd;
        break
    end
end
% X0 = [crd0(1);0;crd0(2);0;crd0(3);0];
% res = nonlinear_approx_rdm(cur_poits(1:381), config, X0); % 10 sec
X0 = [-26911.7337025611; 61.9193794529199;-18882.088847088;-209.599864163006;7129.20359511672;20.4069980130646];
sigma_ksi = 0.10;

Dx0 = eye(9);
track.poits = cur_poits;
% [KFilter] = RDKalmanFilter3D_hgeo(track, config, res.X, Dx0, sigma_ksi,8000,5000);
% [KFilter] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,20);

[KFilter1] = RDKalmanFilter3D(track, config, X0, Dx0, sigma_ksi);
[KFilter2] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,1000);
[KFilter3] = RDKalmanFilter3D_hgeo_inpoits(track, config, X0, Dx0, sigma_ksi,50);

figure(1)
subplot(131)
show_posts2D
show_primary_points2D(cur_poits)
plot(real_track_new.crd(1,:)/1000,real_track_new.crd(2,:)/1000,'.-k')
grid minor
set(gca,'FontSize',18)
set(gca,'FontName','Times')
xlim([-30 40])
ylim([-170 40])
title('Референс')

subplot(132)
show_posts2D
plot(real_track_new.crd(1,:)/1000,real_track_new.crd(2,:)/1000,'.-k')
grid minor
plot(KFilter1.crd(1,:)/1000,KFilter1.crd(2,:)/1000,'r.-')
set(gca,'FontSize',18)
set(gca,'FontName','Times')
xlim([-30 40])
ylim([-170 40])
title('РДФ')

subplot(133)
show_posts2D
plot(real_track_new.crd(1,:)/1000,real_track_new.crd(2,:)/1000,'.-k')
grid minor
plot(KFilter2.crd(1,:)/1000,KFilter2.crd(2,:)/1000,'b.-')
set(gca,'FontSize',18)
set(gca,'FontName','Times')
xlim([-30 40])
ylim([-170 40])
title('РДФВ')

% subplot(144)
% show_posts2D
% plot(real_track_new.crd(1,:)/1000,real_track_new.crd(2,:)/1000,'.-k')
% grid minor
% plot(KFilter3.crd(1,:)/1000,KFilter3.crd(2,:)/1000,'.-')
% set(gca,'FontSize',18)
% set(gca,'FontName','Times')
% xlim([-30 40])
% ylim([-170 40])
set(gcf, 'Position', get(0, 'Screensize'));
    

err1 = err_calc_real_log(real_track_new, KFilter1);
err2 = err_calc_real_log(real_track_new, KFilter2);
% err3 = err_calc_real_log(real_track_new, KFilter3);

% figure
% plot(real_track_new.t,real_track_new.crd(3,:))
% hold on
% plot(KFilter.t,KFilter.crd(3,:))

figure
plot(KFilter1.t,err1.d,'linewidth',1)
hold on
grid minor
plot(KFilter2.t,err2.d,'linewidth',1)
% plot(KFilter3.t,err3.d,'linewidth',1)
xlabel('t, сек')
ylabel('Погрешность, м')
set(gca,'FontSize',18)
set(gca,'FontName','Times')
legend('РДФ','РДФВ s = 100 м')

figure
yyaxis left
plot(KFilter1.t,err1.d_norm*100,'r-','linewidth',1)
hold on
grid minor
plot(KFilter2.t,err2.d_norm*100,'b-','linewidth',1)
% plot(KFilter3.t,err3.D,'linewidth',1)
xlabel('t, сек')
ylabel('Погрешность, %')
yyaxis right
plot(KFilter1.t,err1.dist/1000,'k-','linewidth',2)
ylabel('D, км')
set(gca,'FontSize',18)
set(gca,'FontName','Times')
legend('РДФ','РДФВ s = 100 м','Дальность до ИРИ')
[max(err1.d) max(err2.d) max(err3.d)]
%% h_heo_calc_test
h = [];
for i = 1:length(real_track_new.t)
    h(i) = z_geo_calc(real_track_new.crd(1,i),real_track_new.crd(2,i),real_track_new.crd(3,i));
end
plot(real_track_new.t,h)
hold on
plot([cur_poits.Frame],[cur_poits.h_geo])
