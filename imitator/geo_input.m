function [maneurs]= geo_input(traj_params)
    t=traj_params.time_interval(2);
    time_interval = traj_params.time_interval(1):1:traj_params.time_interval(end);
   
    
    count_mnv = input('Kollichestvo manevrov: ');
        for j = 1:count_mnv
            disp('Vvedite nachalo i konetc manevra');
            
            
            maneurs(j).t0=input('Vremya nachala manevra, time_start = ');
            maneurs(j).t=input('Vremya okonchaniya manevra, time_end = ');
            
            maneurs(j).acc= input('Acceleration, acc = ');
            maneurs(j).omega=input('Angle, omega = ');
           
        end
    

end

    

