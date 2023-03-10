%% track
clear all
close all
config = Config();
traj_params.X0 = [50e3; -50e3]; 
traj_params.V = 200; 
traj_params.kurs = 135; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 600]; 

traj_params.track_id = 0;

traj_params.maneurs(1) = struct('t0',100,'t',200,'acc',0,'omega',0.6);
traj_params.maneurs(2) = struct('t0',300,'t',400,'acc',0,'omega',-0.6);
traj_params.maneurs(3) = struct('t0',500,'t',600,'acc',1,'omega',0);
% 
% traj_params.maneurs(1) = struct('t0',1,'t',600,'acc',0,'omega',0.6);
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
% params.percentage = [0.4 0.4 0.2];
% params.banned_post = 2;
% [track.poits, res] = thinning_measurements(track.poits, params, config);
%% setting the algorithm parameters
paramsT.T_nak = 30;
paramsT.T = 5;
s_ksi = 1;
sigma_Dx0 = 1;
nms = find([track.t] < paramsT.T);
Order = 9; % 3 - X Y Z
           % 6 - X Vx Y Vy Z Vz
           % 9 - X Vx ax Y Vy ay Z Vz az
switch Order
    case 9
        X0 = [track.crd(1,nms(end));track.vel(1,nms(end));track.acc(1,nms(end));
          track.crd(2,nms(end));track.vel(2,nms(end));track.acc(2,nms(end));
          track.crd(3,nms(end));track.vel(3,nms(end));track.acc(3,nms(end));];
        Dx0 = sigma_Dx0*eye(9,9);
%         Dx0 = [2486.40157693869	139.241214726040	2.37248688829085	-2610.38483780034	-146.297369223768	-2.50023399351060	1403.33724236147	79.4474782555995	1.41086847069196;
% 139.241214725998	12.5999135640335	0.534361021464452	-146.297126000887	-13.2638612243840	-0.563567854866729	79.4470739859073	7.37933274928434	0.320791754470004;
% 2.37248688828543	0.534361021464199	0.0519671130961923	-2.50021345871291	-0.563566889363451	-0.0547329981093501	1.41083327427978	0.320789841146495	0.0306289855498402;
% -2610.38483780034	-146.297126000932	-2.50021345871857	2748.34487172523	154.167287540386	2.64391312134174	-1481.12431439244	-83.9343184246959	-1.49601738385362;
% -146.297369223723	-13.2638612243840	-0.563566889363718	154.167287540338	14.0086030172145	0.596494149780274	-83.9341062769898	-7.81487247854901	-0.340478644012439;
% -2.50023399350492	-0.563567854866463	-0.0547329981093501	2.64391312133577	0.596494149779992	0.0578399441234456	-1.49599829629549	-0.340477460726876	-0.0324570445152545;
% 1403.33724236144	79.4470739859298	1.41083327428279	-1481.12431439241	-83.9341062770135	-1.49599829629866	1052.69693667841	60.0971609106733	1.10019217404852;
% 79.4474782555726	7.37933274928416	0.320789841146634	-83.9343184246676	-7.81487247854882	-0.340477460727023	60.0971609106590	5.69246316229326	0.251892965211068;
% 1.41086847068878	0.320791754469853	0.0306289855498401	-1.49601738385028	-0.340478644012279	-0.0324570445152544	1.10019217404674	0.251892965210984	0.0237381283728962;];
    case 6
        X0 = [track.crd(1,nms(end));track.vel(1,nms(end));
          track.crd(2,nms(end));track.vel(2,nms(end));
          track.crd(3,nms(end));track.vel(3,nms(end));];
        Dx0 = sigma_Dx0*eye(6,6);
    case 3
        X0 = [track.crd(1,nms(end));
          track.crd(2,nms(end));
          track.crd(3,nms(end));];
        Dx0 = sigma_Dx0*eye(3,3);
end
%first - our EKF with accumulation poits
%second - simple EKF without accumulation poits
Filter = RDKalmanFilter3D_Accum_Full_Nak(track, config, s_ksi, X0, Dx0, paramsT);

X01 = [track.poits(1).true_crd(1,1); 
      track.poits(1).true_vel(1,1); 
      track.poits(1).true_crd(2,1); 
      track.poits(1).true_vel(2,1); 
      track.poits(1).true_crd(3,1); 
      track.poits(1).true_vel(3,1);];
Dx01 = sigma_Dx0*eye(9,9);
% Dx01 = [4505.52874664683	534.088429296155	32.3065622570123	-4711.15502504919	-551.701293515871	-32.0402479707708	2461.63052010790	273.043342653223	14.4754927345819;
% 534.088429296153	97.2247580425214	8.30638605198089	-551.534878014845	-96.3380737424753	-7.17614194769233	272.611323280095	43.3890112335272	2.77793155475961;
% 32.3065622570123	8.30638605198089	1.23563829960223	-32.0145759663835	-7.17392301375975	-0.665938987239822	14.4118547455451	2.77394424988254	0.203380387452789;
% -4711.15502504919	-551.534878014848	-32.0145759663835	4972.63655134179	588.289609389596	35.4113075538451	-2603.06780174061	-289.934094565813	-15.4863860477759;
% -551.701293515869	-96.3380737424750	-7.17392301375973	588.289609389593	106.508046950415	8.98036073148552	-289.571161132029	-46.4274612549463	-3.01328377388274;
% -32.0402479707704	-7.17614194769231	-0.665938987239823	35.4113075538445	8.98036073148546	1.29595978961171	-15.4331266762863	-3.01023324364357	-0.226349195779970;
% 2461.63052010790	272.611323280095	14.4118547455450	-2603.06780174061	-289.571161132030	-15.4331266762867	2162.64469660260	304.212100108377	22.9864612710752;
% 273.043342653225	43.3890112335274	2.77394424988254	-289.934094565814	-46.4274612549464	-3.01023324364360	304.212100108378	69.0503560948822	7.49771202836413;
% 14.4754927345820	2.77793155475961	0.203380387452789	-15.4863860477759	-3.01328377388275	-0.226349195779972	22.9864612710752	7.49771202836414	1.31353698270013;];
KFilter = RDKalmanFilter3D(track, config, X01, Dx01, s_ksi);

X_true = interp1(track.t, track.crd(1,:), Filter.t);
Y_true = interp1(track.t, track.crd(2,:), Filter.t);
Z_true = interp1(track.t, track.crd(3,:), Filter.t);

for i = 1:length(Filter.X)
    d1(i) = sqrt((Filter.X(1,i)-X_true(i))^2 + (Filter.X(4,i)-Y_true(i))^2);
end 

for i = 1:length(Filter.Dx_hist)
    DRSM1(i) =  2*sqrt(Filter.Dx_hist(1,i) + Filter.Dx_hist(4,i));
end

for i = 1:length(KFilter.X)
    d2(i) = sqrt((KFilter.X(1,i) - track.poits(i).true_crd(1))^2 + (KFilter.X(4,i) - track.poits(i).true_crd(2))^2);
end 

for i = 1:length(KFilter.Dx)
    DRSM2(i) =  2*sqrt(KFilter.Dx(1,i) + KFilter.Dx(4,i));
end

%% any graphics
show_posts2D
show_track2D(track)
hold on
plot(KFilter.crd(1,:)/1000,KFilter.crd(2,:)/1000, "b-")
hold on
plot(Filter.crd(1,:)/1000,Filter.crd(2,:)/1000, "r-", LineWidth=2)
xlabel('x, km')
ylabel('y, km')
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend("posts","model","simple EKF","EKF with accum")
% figure
% plot(track.t,track.crd(3,:)/1000)
% hold on
% plot(Filter.t,Filter.crd(3,:)/1000)
% figure
% plot(track.t, track.crd(1,:)/1000 )
% hold on
% plot(Filter.t, Filter.crd(1,:)/1000)


figure
plot(Filter.t, Filter.Dx_hist(1,:), "r-")
hold on
plot(KFilter.t, KFilter.Dx(1,:), "b-") 
grid on
grid minor

figure
plot(KFilter.t, d2, "b-",LineWidth=0.1)
hold on
plot(KFilter.t, DRSM2, "k-", LineWidth=2)
hold on
plot(Filter.t, d1, "r-", LineWidth=2)
hold on
plot(Filter.t, DRSM1, "c-", LineWidth=3)
grid on
grid minor


