function [] = err_calc_real_log(real_track, res)
    t = res.t;
    
    x = interp1(real_track.t,real_track.crd(1,:),t);
    y = interp1(real_track.t,real_track.crd(2,:),t);
    z = interp1(real_track.t,real_track.crd(3,:),t);
    
    vx = interp1(real_track.t,real_track.vel(1,:),t);
    vy = interp1(real_track.t,real_track.vel(2,:),t);
    vz = interp1(real_track.t,real_track.vel(3,:),t);
    
    err.crd = [res.crd - [x;y;z]];
    err.vel = [res.vel - [vx;vy;vz]];
    
    figure
    subplot(321)
    plot(res.t, err.crd(1,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(1,:));
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('x, m')
    set(gca,'FontSize',14)
    
    subplot(323)
    plot(res.t, err.crd(2,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(4,:));
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('y, m')
    set(gca,'FontSize',14)
    
    subplot(325)
    plot(res.t, err.crd(3,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(7,:));
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('z, m')
    set(gca,'FontSize',14)
    
    subplot(322)
    plot(res.t, err.vel(1,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(2,:));
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('V_x, m/s')
    set(gca,'FontSize',14)
    
    subplot(324)
    plot(res.t, err.vel(2,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(5,:));
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('V_y, m/s')
    set(gca,'FontSize',14)
    
    subplot(326)
    plot(res.t, err.vel(3,:),'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(8,:));
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('V_z, m/s')
    set(gca,'FontSize',14)
    
    set(gcf, 'Position', get(0, 'Screensize'));
    
end

