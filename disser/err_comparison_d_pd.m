function [] = err_comparison_d_pd(track,res,legends, config, s_ksi)

    t = res(1).t;
    
    x = interp1(track.t,track.crd(1,:),t);
    y = interp1(track.t,track.crd(2,:),t);
    z = interp1(track.t,track.crd(3,:),t);
    
    for i = 1:length(x)
        DOP = get_dop_value(config, x(i), y(i), z(i), 'ToF');
        hdop(i) = DOP.HDOP;
    end
    
    D_dm = hdop*config.sigma_n_ns*config.c_ns;

% figure
%     subplot(121)
%      
%   
D = [];
figure
  hold on
  grid minor
  for i = 1:length(res)
      d =[];
    for j = 1:length(res(i).t)
        d(j) = sqrt(sum(res(i).Dx([1 4],j)));
    end
    D(i) = d(end);
    plot(res(i).t,d,'.-')
  end
%   plot(t,D_dm,'--k')
%   plot(track.t,[track.dop.HDOP]*config.sigma_n_ns*config.c_ns,'-.k')
 
  legend(legends)
  xlabel('t, сек')
  ylabel('Погрешность, м')
  title('DRMS')
  set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    
    figure(2)
    semilogx(s_ksi,D(1:end-2))
    grid minor
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    hold on
    
    figure
    hold on
    grid minor
      D =[];
    for j = 1:length(res(end-1).t)
        D(j) = sqrt(sum(res(end-1).Dx([1 4],j)));
    end
    for i = 1:length(res)-2
          d =[];
          for j = 1:length(res(i).t)
              d(j) = sqrt(sum(res(i).Dx([1 4],j)));
          end
          plot(res(i).t,D./d,'linewidth',2)
    end
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    hold on
    legend(legends{1:end-2})
    xlabel('t, сек')
    title('Выигрыш')
    
    figure
    hold on
    grid minor
    for i = 1:length(res)-2
        plot(res(i).ToT/config.c - [track.poits.true_ToT])
    end
    legend(legends{1:end-2})
    
    delta = [track.poits.delta];
%     figure
%     hold on
%     grid minor
    for i = 1:length(res)-2
        figure
        plot(res(i).X(end,:)/config.c,'b')
        hold on
        grid minor
        plot(delta(2,:),'k')
        title(legends{i})
    end
    legend(legends{1:end-2})
%     semilogx(s_ksi,D(end-1)*ones(length(s_ksi)),'--k')
%     semilogx(s_ksi,D(end)*ones(length(s_ksi)),'--k')
%     
%     
%     subplot(122)
%   D =[];
%   for j = 1:length(res(1).t)
%         D(j) = sqrt(sum(res(1).Dx([1 4],j)));
%   end
%   hold on
%   grid minor
%   title('Выигрыш')
%   for i = 2:length(res)
%       d =[];
%     for j = 1:length(res(i).t)
%         d(j) = sqrt(sum(res(i).Dx([1 4],j)));
%     end
%     plot(res(i).t,D./d,'.-')
%   end
%   legend(legends{1:end-1})
%   xlabel('t, сек')
%   ylabel(' ')
%   set(gca,'FontSize',18)
%     set(gca,'FontName','Times')
  
  
 
%   set(gcf, 'Position', get(0, 'Screensize'));
end

