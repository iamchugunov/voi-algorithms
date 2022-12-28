function [d] = dYddtday(X, k, config)
%     d = (X.vy + X.ay * t) * (k-1)/config.c;
    t = X.dt * (k - 1)/config.c;
    d = t* (k - 1)/config.c;
    
end

