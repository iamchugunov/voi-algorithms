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

    type_moov = traj_params.type_moov;
    acc_moov = traj_params.acc_moov;

    dh = traj_params.dh;
    type_dh = traj_params.type_dh;
    

    t = time_interval(1):1:time_interval(end);

    X = [X0;h_geo_calc(X0(1),X0(2),h)];
    dop = get_dop_value(config, X(1,1), X(2,1), X(3,1),'ToA');
    h_geo(1,1) = h;

    % начало суперфункции
    time_priquel = 2; % время предшествующего начала/конца предыдущего манёвра
    V_new = V;
    h_new = h;
    for j = 1:(count_mnv)
         turn_direction = randi(2,1); % случайное определение поворота(лево/право)
         index_type_track = type_mnv(randi(2,1)); % тип манёвра   
         index_type_moov= type_moov(randi(3,1)); % тип изменения скорости
         index_type_dh = type_moov(randi(3,1)); % тип изменения скорости
         
         for i = time_priquel:(length(t)/count_mnv)*j
            % Ускорение
            % возможное рещение проблемы and V > минимально возможной
            % скорости полета  and V < максимально возможной скорости
            % полёта. То же самое нужно будет сделать и для высоты: к
            % сравнению типа высотной динамики добавить сравнение
            % максимальной и минимальной высоты полёта в рамках реального
            % мира
            
            if index_type_moov == 1
                acc_moov = 0;
            elseif index_type_moov == 2 && V_new < 675
                acc_moov = traj_params.acc_moov;
            elseif index_type_moov == 3 && V_new > 95
                acc_moov = - traj_params.acc_moov; 
            else 
                acc_moov = 0;
            end
            
            % манёвры
            
            if  index_type_track == 1
                omega = 0;
            elseif  index_type_track == 2
                omega = traj_params.omega * pi/180;               
            end

            % высота
            
            if index_type_dh == 1
                dh = 0;
            elseif index_type_dh == 2 && h_new < 35e3
                dh = traj_params.dh;
            elseif index_type_dh == 3 && h_new > 305
                dh = - traj_params.dh;
            else 
                dh = 0;
            end
            
         
        V_new = V_new + acc_moov * (t(i)-t(i-1));
        h_new = h_new + dh;
        kurs = kurs +  omega * (-1)^turn_direction * (t(i)-t(i-1));
        Vy = V_new * sin(kurs);
        Vx = V_new * cos(kurs);

       
        X(1,i) = X(1,i-1) + Vx * (t(i) - t(i-1));
        X(2,i) = X(2,i-1) + Vy * (t(i) - t(i-1));
        X(3,i) = h_geo_calc(X(1,i),X(2,i),h_new); 
        dop(i) = get_dop_value(config, X(1,i), X(2,i), X(3,i),'ToA');
        h_geo(:,i) = h_new;
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



