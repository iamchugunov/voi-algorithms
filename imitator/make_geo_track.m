function [track] = make_geo_track(traj_params, config)

    X0 = traj_params.X0;
    V = traj_params.V;
    kurs = traj_params.kurs * pi/180;
    h = traj_params.h;
    time_interval = traj_params.time_interval;
    track_id = traj_params.track_id;
    
   
    t = time_interval(1):1:time_interval(end);
    
    Vx = V * cos(kurs);
    Vy = V * sin(kurs);
    X = [X0;h_geo_calc(X0(1),X0(2),h)];
    dop = get_dop_value(config, X(1,1), X(2,1), X(3,1),'ToA');
    h_geo(1,1) = h;

    for i = 2:length(t) 
        X(1,i) = X(1,i-1) + Vx * (t(i) - t(i-1));
        X(2,i) = X(2,i-1) + Vy * (t(i) - t(i-1));
        X(3,i) = h_geo_calc(X(1,i),X(2,i),h);
        dop(i) = get_dop_value(config, X(1,i), X(2,i), X(3,i),'ToA');
        h_geo(:,i) = h;
    end
    
 track.id = track_id;
    track.t = t;
    track.crd = X;
    coords = X;
    V = [diff(coords(1,:))./diff(t); diff(coords(2,:))./diff(t); diff(coords(3,:))./diff(t);];
    V(:,end + 1) = V(:,end);
    a = [diff(V(1,:))./diff(t); diff(V(2,:))./diff(t); diff(V(3,:))./diff(t);];
    a(:,end) = a(:,end-1);
    a(:,end + 1) = a(:,end-1);
    track.vel = V;
    track.acc = a;
    track.h_geo = h_geo;
    track.dop = dop;
    track.poits = [];
    
end



