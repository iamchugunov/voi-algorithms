function [err] = err_calc(track, res, config)
    
    for i = 1:length(res.t)
        nums = find(track.t <= res.t(i));
        crd = track.crd(:,nums(end));
        vel = track.vel(:,nums(end));
        acc = track.acc(:,nums(end));
        dt = res.t(i) - track.t(nums(end));
        vel = vel + acc * dt;
        crd = crd + vel * dt;
        err.crd(:,i) = res.crd(:,i) - crd;
        err.vel(:,i) = res.vel(:,i) - vel;
        err.acc(:,i) = res.acc(:,i) - acc;
    end
    
    figure
%     subplot(321)
subplot(131)
    plot(res.t, err.crd(1,:),'r','linewidth',2)
    hold on
    grid minor
    D = [1;-1].*3*sqrt(res.Dx(1,:));
    dop = [1;-1].*3*[track.dop.XDOP]*config.sigma_n_ns*config.c_ns;
    plot(res.t,D(1,:),'k','linewidth',1)
    plot(track.t,dop,'k--','linewidth',1)
    plot(res.t,D(2,:),'k','linewidth',1)
    xlabel('t, сек')
    ylabel('x, м')
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    legend('Мгновенная ошибка','±3\surd{Dx_{1,1}}','Предельная погрешность')
    
%     subplot(323)
subplot(132)
    plot(res.t, err.crd(2,:),'r','linewidth',2)
    hold on
    grid minor
    D = [1;-1].*3*sqrt(res.Dx(4,:));
    dop = [1;-1].*3*[track.dop.YDOP]*config.sigma_n_ns*config.c_ns;
    plot(res.t,D(1,:),'k','linewidth',1)
    plot(track.t,dop,'k--','linewidth',1)
    plot(res.t,D(2,:),'k','linewidth',1)
    xlabel('t, сек')
    ylabel('y, м')
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    legend('Мгновенная ошибка','±3\surd{Dx_{4,4}}','Предельная погрешность')
    
%     subplot(325)
    subplot(133)
    plot(res.t, err.crd(3,:),'r','linewidth',2)
    hold on
    grid minor
    D = [1;-1].*3*sqrt(res.Dx(7,:));
    dop = [1;-1].*3*[track.dop.ZDOP]*config.sigma_n_ns*config.c_ns;
    plot(res.t,D(1,:),'k','linewidth',1)
    plot(track.t,dop,'k--','linewidth',1)
    plot(res.t,D(2,:),'k','linewidth',1)
    xlabel('t, сек')
    ylabel('z, м')
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    legend('Мгновенная ошибка','±3\surd{Dx_{7,7}}','Предельная погрешность')
    
%     subplot(322)
%     plot(res.t, err.vel(1,:),'r','linewidth',2)
%     hold on
%     grid minor
%     D = [1;-1].*3*sqrt(res.Dx(2,:));
%     plot(res.t,D,'k','linewidth',1)
%     xlabel('t, сек')
%     ylabel('v_x, м/с')
%     set(gca,'FontSize',14)
%     set(gca,'FontName','Times')
%     
%     subplot(324)
%     plot(res.t, err.vel(2,:),'r','linewidth',2)
%     hold on
%     grid minor
%     D = [1;-1].*3*sqrt(res.Dx(5,:));
%     plot(res.t,D,'k','linewidth',1)
%     xlabel('t, сек')
%     ylabel('v_y, м/с')
%     set(gca,'FontSize',14)
%     set(gca,'FontName','Times')
%     
%     subplot(326)
%     plot(res.t, err.vel(3,:),'r','linewidth',2)
%     hold on
%     grid minor
%     D = [1;-1].*3*sqrt(res.Dx(8,:));
%     plot(res.t,D,'k','linewidth',1)
%     xlabel('t, сек')
%     ylabel('v_z, м/с')
%     set(gca,'FontSize',14)
%     set(gca,'FontName','Times')
    
    set(gcf, 'Position', get(0, 'Screensize'));
    
end

