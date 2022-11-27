function [traj_paramsi]= geo_input(traj_params,~)
  ti=traj_params.time_interval(2);
  aman=[];
  omegaman=[];
  traj_paramsi=[aman,omegaman];
  traj_paramsi.aman=zeros(1,ti+1);
  traj_paramsi.omegaman=zeros(1,ti+1);

 for j=1:traj_params.count_mnv
        disp('Введите начало и конец манёвра');
        traj_paramsi.timer1(j)=input('время начала манёвра, time1 = ');
        traj_paramsi.timer2(j)=input('время конца манёвра, time2 = ');
        if traj_paramsi.timer1(j)>traj_paramsi.timer2(j)
            disp('неправильное время окончания');
            traj_paramsi.timer2(j)=input('время конца манёвра, time2 = ');
        end
        Alfa(j)=input('ускорение для данного манёвра, alfa = ');
        Omega(j)=input('угол поворота для манёвра, omega = ');
        for i=traj_paramsi.timer1(j):traj_paramsi.timer2(j)
            traj_paramsi.aman(i)=Alfa(j);
            traj_paramsi.omegaman(i)=Omega(j);
        end
end
end
