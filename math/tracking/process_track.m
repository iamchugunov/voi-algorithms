function [t, X, Xf] = process_track(track, config, process_params)
    T_nak = process_params.T_nak;
    T_res = process_params.T_res;
    a = process_params.abc(1);
    b = process_params.abc(2);
    c = process_params.abc(3);

    poits = track.poits;
    t = [];
    X = [];
    t_res_last = poits(1).Frame;
    k = 0;
    for i = 1:length(poits)
        if poits(i).Frame - t_res_last > T_res
            k = k + 1;
            t_res_last = poits(i).Frame;
            current_poits = poits(i);
            k1 = 0;
            for j = 1:i
                if poits(i).Frame - poits(j).Frame < T_nak
                    k1 = k1 + 1;
                    current_poits(k1) = poits(j);
                end
            end
            t(k) = t_res_last;
            SV(k) = group_calc(current_poits, config);
            X(:,k) = [SV(k).x0;
                      SV(k).vx;  
                      SV(k).ax;
                      SV(k).y0;
                      SV(k).vy;
                      SV(k).ay;
                      SV(k).z0; 
                      SV(k).vz; 
                      SV(k).az;];
        end
    end
       
    Xf = X;
    for i = 2:length(X)
        dt = t(i) - t(i-1);

        Xf(1,i) = (Xf(1,i-1) + Xf(2,i-1) * dt) * a + (1 - a) * X(1,i);
        Xf(2,i) = (Xf(2,i-1) + Xf(3,i-1) * dt) * b + (1 - b) * X(2,i);
        Xf(3,i) =  Xf(3,i-1) * c + (1 - c) * X(3,i);
        
        Xf(4,i) = (Xf(4,i-1) + Xf(5,i-1) * dt) * a + (1 - a) * X(4,i);
        Xf(5,i) = (Xf(5,i-1) + Xf(6,i-1) * dt) * b + (1 - b) * X(5,i);
        Xf(6,i) =  Xf(6,i-1) * c + (1 - c) * X(6,i);
        
        Xf(7,i) = (Xf(7,i-1) + Xf(8,i-1) * dt) * a + (1 - a) * X(7,i);
        Xf(8,i) = (Xf(8,i-1) + Xf(9,i-1) * dt) * b + (1 - b) * X(8,i);
        Xf(9,i) =  Xf(9,i-1) * c + (1 - c) * X(9,i);
    end
    
end

