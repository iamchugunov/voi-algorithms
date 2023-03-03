function [] = err_comparison(res,legends)
    
      figure
  subplot(321)
  hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(1,:)),'.-')
  end
  legend(legends)
  xlabel('t, сек')
  ylabel('x, м')
  
    subplot(323)
  hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(4,:)),'.-')
  end
  legend(legends)
  xlabel('t, сек')
  ylabel('y, м')
  
  subplot(325)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(7,:)),'.-')
  end
  legend(legends)
  xlabel('t, сек')
  ylabel('z, м')
  
    subplot(322)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(2,:)),'.-')
  end
  legend(legends)
  xlabel('t, сек')
  ylabel('v_x, м/с')
  
     subplot(324)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(5,:)),'.-')
  end
  legend(legends)
  xlabel('t, сек')
  ylabel('v_y, м/с')
  
       subplot(326)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(8,:)),'.-')
  end
  legend(legends)
  xlabel('t, сек')
  ylabel('v_z, м/с')
  
%   set(gcf, 'Position', get(0, 'Screensize'));
end

