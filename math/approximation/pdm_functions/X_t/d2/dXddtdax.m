function [d] = dXddtdax(X, k, config)
%     d = (X.vx + X.ax * t)*(k-1)/config.c;
    t = X.dt * (k - 1)/config.c;
%     d = t;
    d = t* (k - 1)/config.c;
end