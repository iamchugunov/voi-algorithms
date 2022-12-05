function [maneur]= geo_input(traj_params)
    t=traj_params.time_interval(2);
    time_interval = traj_params.time_interval(1):1:traj_params.time_interval(end);
    
    maneur.a_mnu=zeros(1,t+1);
    maneur.omega_mnu=zeros(1,t+1);
    gii = traj_params.geo_input_instruction;
   
   if gii == 1
       maneur.count_mnv = input('Количество манёвров: ');
        for j = 1:maneur.count_mnv
            disp('Введите начало и конец манёвра');
            maneur.time_start(j)=input('время начала манёвра, time_start = ');
            maneur.time_end(j)=input('время конца манёвра, time_end = ');
            acc(j) = input('ускорение для участка трэка, acc = ');
            omega(j)=input('угол поворота для манёвра, omega = ');
            for i=maneur.time_start(j):maneur.time_end(j)
                maneur.a_mnu(i) = acc(j);
                maneur.omega_mnu(i) = omega(j);
            end
        end
   elseif gii == 2
       maneur.time_start(1) = time_interval(100);
       maneur.time_end(1)   = time_interval(200);
       for i = maneur.time_start(1):maneur.time_end(1)
                maneur.a_mnu(i)     = 0;
                maneur.omega_mnu(i) = 0.6;
       end
       maneur.time_start(2) = time_interval(400);
       maneur.time_end(2)   = time_interval(500);
       for i = maneur.time_start(2):maneur.time_end(2)
                maneur.a_mnu(i)     =    0;
                maneur.omega_mnu(i) = -0.6;
       end
       maneur.time_start(3) = time_interval(550);
       maneur.time_end(3)   = time_interval(600);
       for i = maneur.time_start(3):maneur.time_end(3)
                maneur.a_mnu(i)     = 1;
                maneur.omega_mnu(i) =  0;
       end
   elseif gii == 3
       maneur.time_start(1) = time_interval(2);
       maneur.time_end(1)   = time_interval(end);
       for i = maneur.time_start(1):maneur.time_end(1)
                maneur.a_mnu(i)     = 0;
                maneur.omega_mnu(i) = 0.6;
       end
   elseif gii == 4
       maneur.time_start(1) = time_interval(2);
       maneur.time_end(1)   = time_interval(300);
       for i = maneur.time_start(1):maneur.time_end(1)
                maneur.a_mnu(i)     = 0.5;
                maneur.omega_mnu(i) = 0;
       end
       maneur.time_start(2) = time_interval(301);
       maneur.time_end(2)   = time_interval(600);
       for i = maneur.time_start(2):maneur.time_end(2)
                maneur.a_mnu(i)     =-0.5;
                maneur.omega_mnu(i) = 0;
       end    
   end   

end

    

