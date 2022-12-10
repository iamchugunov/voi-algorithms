function [SV] = group_calc(poits, config)
    t = [];
    crd = [];
    k = 0;
    for i = 1:length(poits)
        poits(i) = crd_calc(poits(i),config);
        if (poits(i).crd_valid)
            k = k + 1;
            t(k) = poits(i).Frame;
            crd(:,k) = poits(i).est_crd;
            
        end
        
    end
       
        
    [koef, sko, X] = mnk_approx_step( t - t(1), crd(1,:), 2);
    SV.x0 = koef(1) + koef(2) * (t(end) - t(1));        
    SV.vx = koef(2) + koef(3) * (t(end) - t(1));
    SV.ax = koef(3);
    [koef, sko, Y] = mnk_approx_step( t - t(1), crd(2,:), 2);
    SV.y0 = koef(1) + koef(2) * (t(end) - t(1));
    SV.vy = koef(2) + koef(3) * (t(end) - t(1));
    SV.ay = koef(3);
    [koef, sko, Z] = mnk_approx_step( t - t(1), crd(3,:), 2);
    SV.z0 = koef(1) + koef(2) * (t(end) - t(1));
    SV.vz = koef(2) + koef(3) * (t(end) - t(1));
    SV.az = koef(3);
    
    %{
    show_posts3D
    show_primary_points3D(poits)
    plot3(X/1000,Y/1000,Z/1000,'.-')
    %}
end

