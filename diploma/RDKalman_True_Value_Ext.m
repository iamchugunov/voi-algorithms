function [X_true] = RDKalman_True_Value_Ext(track, t)
    X_true = [];
    for j = 1:length(t)
        for i = 2:length(track.t)
            if track.t(i) > t(j) 
                dt = t(j) - track.t(i-1);

                X_true(1,j) = track.crd(1,i-1) + dt * track.vel(1,i-1);
                X_true(2,j) = track.vel(1,i-1) + dt * track.acc(1,i-1);
                X_true(3,j) = track.acc(1,i-1);

                X_true(4,j) = track.crd(2,i-1) + dt * track.vel(2,i-1);
                X_true(5,j) = track.vel(2,i-1) + dt * track.acc(2,i-1);
                X_true(6,j) = track.acc(2,i-1);

                X_true(7,j) = track.crd(3,i-1) + dt * track.vel(3,i-1);
                X_true(8,j) = track.vel(3,i-1) + dt * track.acc(3,i-1);
                X_true(9,j) = track.acc(3,i-1);
                j = j + 1;
            end    
        end  
    end
end