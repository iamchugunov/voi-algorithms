function [discr, brd] = get_discr_by_param_rdm(poits, config, X, param, brd)
    t = [poits.Frame];
    t0 = t(1);
    t = t - t0;
        
    discr = [];
    
    X = ones(length(X),length(brd)).*X;
    X(param,:) = brd;
    for j = 1:length(brd)
        dpdX = zeros(9, 1);
        dp2d2X = zeros(9, 9);
        x.x = X(1,j);
        x.vx = X(2,j);
        x.ax = X(3,j);
        x.y = X(4,j);
        x.vy = X(5,j);
        x.ay = X(6,j);
        x.z = X(7,j);
        x.vz = X(8,j);
        x.az = X(9,j);
        for i = 1:length(t)
            toa = poits(i).ToA * config.c_ns;
            nms = find(toa > 0);
            toa = toa(nms);% + (poits(i).Frame - t0)*config.c_ns;
            posts = config.posts(:,nms);
            [d, dd] = get_deriv_rdm(x, t(i), toa, posts);
            dpdX = dpdX + d;
            dp2d2X = dp2d2X + dd;
        end
        dpdX = dpdX / (config.sigma_n_ns * config.c_ns)^2;
        dp2d2X = dp2d2X / (config.sigma_n_ns * config.c_ns)^2;
        discr(j) = dpdX(param);
    end
end



