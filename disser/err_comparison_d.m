function [] = err_comparison_d(res,legends)
     figure
    subplot(121)
     
  
  hold on
  grid minor
  for i = 2:length(res)
      d =[];
    for j = 1:length(res(i).t)
        d(j) = sqrt(sum(res(i).Dx([1 4],j)));
    end
    plot(res(i).t,d,'.-')
  end
  d =[];
  for j = 1:length(res(1).t)
        d(j) = sqrt(sum(res(1).Dx([1 4],j)));
  end
  plot(res(1).t,d,'.-')
  legend(legends)
  xlabel('t, сек')
  ylabel('Погрешность, м')
  title('DRMS')
  set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    
    
    subplot(122)
  D =[];
  for j = 1:length(res(1).t)
        D(j) = sqrt(sum(res(1).Dx([1 4],j)));
  end
  hold on
  grid minor
  title('Выигрыш')
  for i = 2:length(res)
      d =[];
    for j = 1:length(res(i).t)
        d(j) = sqrt(sum(res(i).Dx([1 4],j)));
    end
    plot(res(i).t,D./d,'.-')
  end
  legend(legends{1:end-1})
  xlabel('t, сек')
  ylabel(' ')
  set(gca,'FontSize',18)
    set(gca,'FontName','Times')
  
  
 
%   set(gcf, 'Position', get(0, 'Screensize'));
end

