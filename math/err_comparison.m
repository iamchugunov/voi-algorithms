function [] = err_comparison(res,legends)
    
      figure
  subplot(321)
  hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(1,:)),'.-')
  end
  legend(legends)
  xlabel('t, ���')
  ylabel('x, �')
  
    subplot(323)
  hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(4,:)),'.-')
  end
  legend(legends)
  xlabel('t, ���')
  ylabel('y, �')
  
  subplot(325)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(7,:)),'.-')
  end
  legend(legends)
  xlabel('t, ���')
  ylabel('z, �')
  
    subplot(322)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(2,:)),'.-')
  end
  legend(legends)
  xlabel('t, ���')
  ylabel('v_x, �/�')
  
     subplot(324)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(5,:)),'.-')
  end
  legend(legends)
  xlabel('t, ���')
  ylabel('v_y, �/�')
  
       subplot(326)
hold on
  grid minor
  for i = 1:length(res)
    plot(res(i).t,sqrt(res(i).Dx(8,:)),'.-')
  end
  legend(legends)
  xlabel('t, ���')
  ylabel('v_z, �/�')
  
%   set(gcf, 'Position', get(0, 'Screensize'));
end

