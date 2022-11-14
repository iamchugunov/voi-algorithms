function [track] = make_geo_ultima(traj_params, config)

    X0 = traj_params.X0;
    V = traj_params.V;
    kurs = traj_params.kurs * pi/180;
    h = traj_params.h;
    time_interval = traj_params.time_interval;
    track_id = traj_params.track_id;

    omega = traj_params.omega * pi/180;
    count_mnv = traj_params.count_mnv;
    type_mnv = traj_params.type_mnv;
    

    t = time_interval(1):1:time_interval(end);

    X = [X0;h_geo_calc(X0(1),X0(2),h)];
    dop = get_dop_value(config, X(1,1), X(2,1), X(3,1),'ToA');
    h_geo(1,1) = h;
    % начало суперфункции
    time_priquel = 2; % время предшествующего начала/конца предыдущего манёвра
    for j = 1:(count_mnv)
         index_type_mnv = randi(2,1); % случайное определение команды для манёвра
         type_track = type_mnv(index_type_mnv); % тип манёвра 
         turn_direction = randi(2,1); % случайное определение поворота(лево/право)
         for i = time_priquel:(length(t)/count_mnv)*j
            %{ попытка реализации типа манёвра ч
            if  strcmp("line",type_track) == true
                omega = 0;
            elseif strcmp("circle",type_track) == true
                omega = traj_params.omega * pi/180;

            end
            %}
            if type_track == 1
                omega = 0;
            elseif type_track == 2
                omega = traj_params.omega * pi/180;
                
            end
         
         

         kurs = kurs +  omega* (-1)^turn_direction * (t(i)-t(i-1));
         Vy = V * sin(kurs);
         Vx = V * cos(kurs);

        X(1,i) = X(1,i-1) + Vx * (t(i) - t(i-1));
        X(2,i) = X(2,i-1) + Vy * (t(i) - t(i-1));
        X(3,i) = h_geo_calc(X(1,i),X(2,i),h); %изменение высоты ( + i * 100)
        dop(i) = get_dop_value(config, X(1,i), X(2,i), X(3,i),'ToA');
        h_geo(:,i) = h;
        end 
        time_priquel = i;
    end

    % конец суперфункции

    
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


