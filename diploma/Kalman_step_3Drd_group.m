function [X, Dx, discr] = Kalman_step_3Drd_group(y, X_prev, Dx, dt, sigma_n, D_ksi, config)
    % TDoA Kalman
    % X = [x vx ax y vy ay z vz az]
    nums = find(y ~= 0);
    posts = config.posts(:,nums);
    y = y(nums);
    N = length(nums);

    % D_n = eye(N) * sigma_n^2;

    H = zeros(N-1,N);
    H(:,end) = 1;
    for i = 1:N-1
        H(i,i) = -1;
    end

    switch N
        case 4
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 3
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 2
            HDnHT = 2 * sigma_n^2;
            HDnHTrev = inv(HDnHT);
    end
           

    F1 = [1 dt dt^2/2; 0 1 dt; 0 0 1];
    F = zeros(9,9);
    F(1:3,1:3) = F1;
    F(4:6,4:6) = F1;
    F(7:9,7:9) = F1;

    G = zeros(9,3);
    G(3,1) = dt;
    G(6,2) = dt;
    G(9,3) = dt;

   

    X_ext = F * X_prev;
    D_x_ext = F * Dx * F' + G * D_ksi * G';
    dS = make_dS(y, X_ext, posts);
    S = make_S(y, X_ext, posts);
    
    Dx = inv(inv(D_x_ext) - dS' * H' * HDnHTrev * H * dS);
    K = Dx * dS' * H' * HDnHTrev;
   
    discr = H*y - H*S;
    X = X_ext + K*(discr);
end

function dS = make_dS(y, X, posts)
    dS = zeros(length(y),length(X));
    for i = 1:length(y)
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2);
        dS(i,1) = (X(1,1) - posts(1,i))/d;
        dS(i,4) = (X(4,1) - posts(2,i))/d;
        dS(i,7) = (X(7,1) - posts(3,i))/d;
    end
end

function S = make_S(y, X, posts)
    S = zeros(length(y),1);
    for i = 1:length(y)
        S(i,1) = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2);
    end
end