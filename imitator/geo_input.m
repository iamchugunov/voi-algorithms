function [maneur]= geo_input(traj_params)
    ti=traj_params.time_interval(2);
    maneur.aman=zeros(1,ti+1);
    maneur.omegaman=zeros(1,ti+1);
    % без защиты от дурака
    maneur.count_mnv = input('Количество манёвров: ');
    for j = 1:maneur.count_mnv
        disp('Введите начало и конец манёвра');
        maneur.timer1(j)=input('время начала манёвра, time1 = ');
        while (j>1 & maneur.timer1(j)<=maneur.timer1(j-1)) | (maneur.timer1(j)/10)~=0 | maneur.timer1(j)<1
            disp('время начала не соответсвует концепции времени');
            maneur.timer1(j)=input('время начала манёвра, time1 = '); 
            if (j>1 & maneur.timer1(j)>maneur.timer1(j-1)) | (maneur.timer1(j)/10)==0 | maneur.timer1(j)>=1
                break
            end
        end
        maneur.timer2(j)=input('время конца манёвра, time2 = ');
        while maneur.timer1(j)>maneur.timer2(j) | (maneur.timer2(j)/10)~=0 | maneur.timer2(j)<1
            disp('время окончания не соответсвует концепции времени');
            maneur.timer2(j)=input('время конца манёвра, time2 = ');
            if   maneur.timer1(j)<=maneur.timer2(j) | (maneur.timer2(j)/10)==0 | maneur.timer2(j)>1
                break
            end
        end
        acs(j)=input('ускорение для участка трэка, alfa = ');
        omega(j)=input('угол поворота для манёвра, omega = ');
        for i=maneur.timer1(j):maneur.timer2(j)
            maneur.aman(i)=acs(j);
            maneur.omegaman(i)=omega(j);
        end
    end
end
