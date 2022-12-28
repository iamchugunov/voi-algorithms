
clear all
config = Config(); 

traj_params.X0 = [randi([-100 100]);randi([-100 100])]*1e3; 
% traj_params.X0 = [50; 50]*1e3; 
traj_params.V = 0; 
traj_params.kurs = 120; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 100]; 
traj_params.track_id = 0;
track = make_geo_track(traj_params, config);

measurements_params.sigma_n_ns = config.sigma_n_ns*0;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 10;
measurements_params.strob_dur = 0.12;
% measurements_params.strob_dur = 1e8;
track = make_measurements_for_track(track, measurements_params, config);
params.mode = 1;
params.percentage = [0 1 0];
params.banned_post = 1;
[poits, res] = thinning_measurements(track.poits, params, config);
%%
N = 3;
show_posts2D
show_hyperbols(poits(N).ToA(find(poits(N).ToA))*config.c_ns, config.posts(:,find(poits(N).ToA)), poits(N).true_crd(3), 3);
show_track2D(track)
if poits(N).count == 4
    poits(N) = crd_calc4a(poits(N),config);
    res = poits(N).res;
    res.x
    plot(res.x(1,:)/1000,res.x(2,:)/1000,'o','linewidt',2,'markersize',10)
end
if poits(N).count == 3
    poits(N) = crd_calc3a(poits(N),config);
    res = poits(N).res;
    res.x
    plot(res.x(1,:)/1000,res.x(2,:)/1000,'x','linewidt',2,'markersize',10)
    poits(N) = crd_calc3(poits(N),config);
    res = poits(N).res;
    res.X
    plot(res.X(1,:)/1000,res.X(2,:)/1000,'pentagram','linewidt',2,'markersize',5)
end
