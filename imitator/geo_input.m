function [maneurs]= geo_input()
       
    count_mnv = input('Kollichestvo manevrov: ');
    if count_mnv~=0
        for j = 1:count_mnv
            disp('Vvedite nachalo i konetc manevra');
            
            
            maneurs(j).t0=input('Vremya nachala manevra, time_start = ');
           
            if j == 2
                while (maneurs(j).t0<= maneurs(j-1).t )
                maneurs(j).t0=input('Pravilnoe Vremya nachala manevra, time_start = ');
                end
            end
                while (maneurs(j).t0-round(maneurs(j).t0)~=0 || maneurs(j).t0<0  )
                    maneurs(j).t0=input('Pravilnoe Vremya nachala manevra, time_start = ');
                end
                
            maneurs(j).t=input('Vremya okonchaniya manevra, time_end = ');

                while ((maneurs(j).t-round(maneurs(j).t)~=0) || (maneurs(j).t<0) || (maneurs(j).t<=maneurs(j).t0))
                    maneurs(j).t=input('Pravilnoe Vremya okonchania manevra, time_end = ');
                end

            maneurs(j).acc= input('Acceleration, acc = ');
            maneurs(j).omega=input('Angle, omega = ');
           
        end
    else
        maneurs=[];
    end

end

    

