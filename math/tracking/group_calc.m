function [SV] = group_calc(poits, config)
    t = [];
    crd = [];
    k = 0;
    for i = 1:length(poits)
        if poits(i).count == 4
            poits(i) = crd_calc(poits(i),config);
            if (poits(i).crd_valid)
                k = k + 1;
                t(k) = poits(i).Frame;
                crd(:,k) = poits(i).est_crd;
            end
        end
    end
    
    [koef, sko, X] = mnk_approx_step(t-t(1), crd(1,:), 1);
    SV.x0 = koef(1);% + koef(2) * (t(end) - t(1));
    SV.vx = koef(2);
    [koef, sko, Y] = mnk_approx_step(t-t(1), crd(2,:), 1);
    SV.y0 = koef(1);% + koef(2) * (t(end) - t(1));
    SV.vy = koef(2);
    [koef, sko, Z] = mnk_approx_step(t-t(1), crd(3,:), 1);
    SV.z0 = koef(1);% + koef(2) * (t(end) - t(1));
    SV.vz = koef(2);
    
    SV.sv = [SV.x0;SV.vx;SV.y0;SV.vy;SV.z0;SV.vz];
    SV.crd = [SV.x0;SV.y0;SV.z0];
    for i = 2:length(t)
        dt = t(i) - t(i-1);
        SV.crd(1,i) = SV.crd(1,i-1) + dt * SV.vx;
        SV.crd(2,i) = SV.crd(2,i-1) + dt * SV.vy;
        SV.crd(3,i) = SV.crd(3,i-1) + dt * SV.vz;
    end
%     show_posts3D
%     show_primary_points3D(poits)
%     plot3(X/1000,Y/1000,Z/1000,'.-')

end

