%% расчет в стационарной точке
clear all
config = Config(); % конфиг содержит координаты постов

traj_params.X0 = [randi([-100 100]);randi([-100 100])]*1e3; % начальные координаты, м
% traj_params.X0 = [50; 50]*1e3; % начальные координаты, м
traj_params.V = 0; % скорость, м/c
traj_params.kurs = 120; % направление, град
traj_params.h = 10e3; % высота над уровнем моря, м
traj_params.time_interval = [0 60]; % временной отрезок, сек
traj_params.track_id = 0;
track = make_geo_track(traj_params, config);

% формирование измерений

measurements_params.sigma_n_ns = config.sigma_n_ns*0;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 10;
measurements_params.strob_dur = 0.12;
% measurements_params.strob_dur = 1e8;
track = make_measurements_for_track(track, measurements_params, config);
%%

params.mode = 1;
params.percentage = [0 1 0];
Master = 1;
N = 2;
params.banned_post = N;

[bnp_poits.poits, res] = thinning_measurements(track.poits, params, config);
subplot(2,1,1)
show_posts2D

show_hyperbols(bnp_poits.poits(N).ToA(find(bnp_poits.poits(N).ToA))*config.c_ns, ...
               config.posts(:,find(bnp_poits.poits(N).ToA)), ...
               bnp_poits.poits(N).true_crd(3), ...
               Master);

show_track2D(track)
hold on

    if bnp_poits.poits(N).count == 4
        bnp_poits.poits(N) = crd_calc4a(bnp_poits.poits(N),config);
        resCC4a = bnp_poits.poits(N).res;
        resCC4a.x
        plot(resCC4a.x(1,:)/1000,resCC4a.x(2,:)/1000,'o','linewidt',2,'markersize',10)
    end
    if bnp_poits.poits(N).count == 3
        bnp_poits.poits(N) = crd_calc3a(bnp_poits.poits(N),config);
        resCC3a = bnp_poits.poits(N).res;
        resCC3a.x
        plot(resCC3a.x(1,:)/1000,resCC3a.x(2,:)/1000,'x','linewidt',2,'markersize',10)
        bnp_poits.poits(N) = crd_calc3(bnp_poits.poits(N),config);
        resCC3 = bnp_poits.poits(N).res;
        resCC3.X
        plot(resCC3.X(1,:)/1000,resCC3.X(2,:)/1000,'pentagram','linewidt',2,'markersize',5)
    end

if resCC3.X(1,1) == resCC3a.x(1,1) && resCC3.X(2,2) == resCC3a.x(2,2) 
    res_True = resCC3a.x(:,1);
else
    res_True = resCC3a.x(:,2);
end


subplot(2,1,2)
show_posts2D

show_hyperbols(bnp_poits.poits(N).ToA(find(bnp_poits.poits(N).ToA))*config.c_ns, ...
               config.posts(:,find(bnp_poits.poits(N).ToA)), ...
               bnp_poits.poits(N).true_crd(3), ...
               Master);

show_track2D(track)
hold on
plot(res_True(1,:)/1000,res_True(2,:)/1000,'*','linewidt',2,'markersize',10)

% I thought that the iterative method would be more accurate than the analytical one,
% so I set the identity of coordinates as the criterion of accuracy. 
% But I found the result of such a decision near the posts, 
% and the "imaginary" point turned out to be a simulated one. I keep
% thinking...





