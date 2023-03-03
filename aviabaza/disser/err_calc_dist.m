function [err] = err_calc_dist(track, res, config)
    
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
    
    
    for i = 1:length(err.crd)
        err.d(i) = norm(err.crd(1:2,i));
    end
    
    t = track.t;
    xdop = [track.dop.XDOP];
    ydop = [track.dop.YDOP];
    zdop = [track.dop.ZDOP];
    hdop = [track.dop.HDOP]* config.sigma_n_ns * config.c_ns * 3;
    
    for i = 1:length(res.Dx)
        D(i) = sqrt(sum(res.Dx([1 4],i)));
    end
    D = D * 2;
    
        
    xdop1 = interp1(t, xdop, res.t) * config.sigma_n_ns * config.c_ns * 2;
    ydop1 = interp1(t, ydop, res.t) * config.sigma_n_ns * config.c_ns * 2;
    zdop1 = interp1(t, zdop, res.t) * config.sigma_n_ns * config.c_ns * 2;
    
    
    figure
    
    plot(res.t, err.d,'r','linewidth',1)
    hold on
    grid minor
%     plot(track.t, hdop,'k--')
    plot(res.t, D,'k--','linewidth',2)
    xlabel('t, сек')
    ylabel('Погрешность, м')
    set(gca,'FontSize',18)
    set(gca,'FontName','Times')
    legend('d','2DRMS')
    
%     set(gcf, 'Position', get(0, 'Screensize'));
    
end

