function [err] = err_calc_poits(track, poits, config)
    
    err.crd = [poits.est_crd] - [poits.true_crd];
    res.t = [poits.Frame];
    
    t = track.t;
    xdop = [track.dop.XDOP];
    ydop = [track.dop.YDOP];
    zdop = [track.dop.ZDOP];
    
    
    
    figure
    subplot(311)
    plot(res.t, err.crd(1,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*xdop*config.sigma_n_ns*config.c_ns;
    plot(t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('x, m')
    set(gca,'FontSize',14)
    
    subplot(312)
    plot(res.t, err.crd(2,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*ydop*config.sigma_n_ns*config.c_ns;
    plot(t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('y, m')
    set(gca,'FontSize',14)
    
    subplot(313)
    plot(res.t, err.crd(3,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*zdop*config.sigma_n_ns*config.c_ns;
    plot(t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('z, m')
    set(gca,'FontSize',14)
    
%     set(gcf, 'Position', get(0, 'Screensize'));
    
end

