function [d] = dXddt(X, k, config)
    t = X.dt * (k - 1)/config.c;
%     d = X.vx + X.ax * t;
    d = (X.vx + X.ax * t)*(k-1)/config.c;
end