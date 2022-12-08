function [] = discrimination_characteristic_rdm(poits, config, X)
        
    [discr_x, x] = get_discr_by_param_rdm(poits, config, X, 1, X(1,1) - 20e3: 1e3: X(1,1) + 20e3);
    [discr_y, y] = get_discr_by_param_rdm(poits, config, X, 4, X(4,1) - 20e3: 1e3: X(4,1) + 20e3);
    [discr_z, z] = get_discr_by_param_rdm(poits, config, X, 7, X(7,1) - 3e3: 100: X(7,1) + 3e3);
    
    subplot(311)
    plot(x,discr_x,'r','linewidth',2)
    hold on
    grid on
    plot([X(1,:) X(1,:)],[min(discr_x) max(discr_x)],'g--')
    xlabel('x')
    
    subplot(312)
    plot(y,discr_y,'r','linewidth',2)
    hold on
    grid on
    plot([X(4,:) X(4,:)],[min(discr_y) max(discr_y)],'g--')
    xlabel('y')
    
    subplot(313)
    plot(z,discr_z,'r','linewidth',2)
    hold on
    grid on
    plot([X(7,:) X(7,:)],[min(discr_z) max(discr_z)],'g--')
    xlabel('z')
    
    
end

