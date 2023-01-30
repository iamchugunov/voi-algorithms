function [d] = dXddtddt(X, k, config)
%     d = (X.vx + X.ax * t)*(k-1)/config.c;    
    t = X.dt * (k - 1)/config.c;
    d = X.ax*(k-1)/config.c*(k-1)/config.c;
end