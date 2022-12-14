function [track] = make_geo_track_new(traj_params, config)

    X0 = traj_params.X0;
    V = traj_params.V;
    kurs = traj_params.kurs * pi/180;
    h = traj_params.h;
    time_interval = traj_params.time_interval;
    track_id = traj_params.track_id;
    %acc_moov=traj_params.aman;
   
    
     a_mnu=zeros(1,traj_params.time_interval(2)+1);
     omega=zeros(1,traj_params.time_interval(2)+1);
    for j=1:length(traj_params.maneurs)
       
       for i=traj_params.maneurs(j).t0:traj_params.maneurs(j).t
                a_mnu(i) = traj_params.maneurs(j).acc;
                omega(i) =  traj_params.maneurs(j).omega* pi/180;
       end
    end
  
    t = time_interval(1):1:time_interval(end);

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
