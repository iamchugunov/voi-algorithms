function [track] = make_geo_track_circle(traj_params, config)

    X0 = traj_params.X0;
    V = traj_params.V;
    kurs = traj_params.kurs * pi/180;
    h = traj_params.h;
    time_interval = traj_params.time_interval;
    track_id = traj_params.track_id;
    t = time_interval(1):1:time_interval(end);
    
   
    X = [X0;h_geo_calc(X0(1),X0(2),h)];
    dop = get_dop_value(config, X(1,1), X(2,1), X(3,1),'ToA');
    h_geo(1,1) = h;
    for i = 2:length(t)

<<<<<<< Updated upstream
         a=kurs+(i*pi/180);
         % kurs = kurs + traj_params.omega * (t(i) - t(i-1));
         Vy = V * sin(a);
         Vx = V * cos(a);
=======
        a=kurs+(i*pi/180);
        Vy = V * sin(a);
        Vx = V * cos(a);
>>>>>>> Stashed changes
              
        X(1,i) = X(1,i-1) + Vx * (t(i) - t(i-1));
        X(2,i) = X(2,i-1) + Vy * (t(i) - t(i-1));
        X(3,i) = h_geo_calc(X(1,i),X(2,i),h); %изменение высоты ( + i * 100)
        dop(i) = get_dop_value(config, X(1,i), X(2,i), X(3,i),'ToA');
        h_geo(:,i) = h;
    end
    
   track= track_something(X,t,track_id,h_geo,dop);
    
end



