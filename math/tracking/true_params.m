function [X_true] = true_params(track, t)
    %poits = track.poits;

    X_true = [];
    
    for j = 1:length(t)
        for i = 2:length(track.t)
            if track.t(i) > t(j) 
                dt = t(j) - track.t(i-1);

                X_true(1,j) = track.crd(1,i-1) + dt * track.vel(1,i-1);
                X_true(2,j) = track.vel(1,i-1) + dt * track.acc(1,i-1);

                X_true(3,j) = track.crd(2,i-1) + dt * track.vel(2,i-1);
                X_true(4,j) = track.vel(2,i-1) + dt * track.acc(2,i-1);

                X_true(5,j) = track.crd(3,i-1) + dt * track.vel(3,i-1);
                X_true(6,j) = track.vel(3,i-1) + dt * track.acc(3,i-1);
        
                j = j + 1;
            end    
        end  
    end
    %{
    figure
    subplot(3,1,1), plot(t,X_true(1,:),'r')
    subplot(3,1,2), plot(t,X_true(2,:),'b')
    subplot(3,1,3), plot(t,X_true(3,:),'g')
    %}
end