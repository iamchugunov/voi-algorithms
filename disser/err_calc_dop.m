function [err] = err_calc_dop(track, res, config)
    
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
    
    t = track.t;
    xdop = [track.dop.XDOP];
    ydop = [track.dop.YDOP];
    zdop = [track.dop.ZDOP];
    
    xdop1 = interp1(t, xdop, res.t) * config.sigma_n_ns * config.c_ns * 3;
    ydop1 = interp1(t, ydop, res.t) * config.sigma_n_ns * config.c_ns * 3;
    zdop1 = interp1(t, zdop, res.t) * config.sigma_n_ns * config.c_ns * 3;
    
    
    figure
    subplot(311)
    plot(res.t, err.crd(1,:)./xdop1,'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(1,:))./xdop1;
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('x/dop_x, m')
    set(gca,'FontSize',14)
    
    subplot(312)
    plot(res.t, err.crd(2,:)./ydop1,'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(4,:))./ydop1;
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('y/dop_y, m')
    set(gca,'FontSize',14)
    
    subplot(313)
    plot(res.t, err.crd(3,:)./zdop1,'r','linewidth',2)
    hold on
    grid on
    D = [1;-1].*3*sqrt(res.Dx(7,:))./zdop1;
    plot(res.t,D,'k','linewidth',1)
    xlabel('t, sec')
    ylabel('z/dop_z, m')
    set(gca,'FontSize',14)
    
%     set(gcf, 'Position', get(0, 'Screensize'));
    
end

