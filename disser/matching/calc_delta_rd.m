function [dd1, dd2] = calc_delta_rd(config, X, V, alpha, t)
    
    post1 = config.posts(:,1);
    post2 = config.posts(:,2);
    
    v = [V * cos(alpha*pi/180); V * sin(alpha*pi/180); 0];
    
    X1 = X;
    X2 = X + v*t;
    
    rd1 = norm(X1 - post2) - norm(X1 - post1);
    rd2 = norm(X2 - post2) - norm(X2 - post1);
    
    dd1 = rd2 - rd1;
    
    R1 = norm(X - post1);
    R2 = norm(X - post2);
    
    dd2 = v' * t * ((X - post2)/R2 - (X - post1)/R1);
    
end

