function [track] = make_geo_track_new1(traj_params, config)

    X0 = traj_params.X0;
    V = traj_params.V;
    kurs = traj_params.kurs * pi/180;
    h = traj_params.h;
    time_interval = traj_params.time_interval;
    track_id = traj_params.track_id;
    
    dt = 1;
    
    t = time_interval(1):dt:time_interval(end);
    a = zeros(1,t);
    w = zeros(1,t);
    
    for j=1:length(traj_params.maneurs)
       t1 = traj_params.maneurs(j).t0;
       t2 = traj_params.maneurs(j).t;
       n1 = find(t == t1);
       n2 = find(t == t2);
       a(n1:n2) = traj_params.maneurs(j).acc;
       w(n1:n2) = traj_params.maneurs(j).omega;
    end
  
    F = [1 dt dt^2/2 0 0 0; 
        0 1 dt 0 0 0; 
        0 0 1 0 0 0;
        0 0 0 1 dt dt^2/2;
        0 0 0 0 1 dt;
        0 0 0 0 0 1];
    
    X(:,1) = [X0(1); V*cos(kurs); a(1)*cos(kurs); X0(2);  V*sin(kurs); a(1)*sin(kurs)];
    
    for i = 2:length(t)
        X(:,i) = F * X(:,i-1);
    end

    X = [X0;h_geo_calc(X0(1),X0(2),h)];
    dop = get_dop_value(config, X(1,1), X(2,1), X(3,1),'ToA');
    h_geo(1,1) = h;

    V_new = V;

    for i=2:length(t)
        if (V_new < 675) && (V_new > 95)
            acc_moov = a_mnu(i); 
        else 
            acc_moov = 0;
        end

        V_new = V_new + acc_moov * (t(i)-t(i-1));
        kurs = kurs +  omega(i) *  (t(i)-t(i-1));
        %Vy= V_new * sin(kurs);
        %Vx= V_new * cos(kurs);
        X(1,i) = X(1,i-1) + V_new * cos(kurs) * (t(i) - t(i-1));
        X(2,i) = X(2,i-1) + V_new * sin(kurs) * (t(i) - t(i-1));
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


