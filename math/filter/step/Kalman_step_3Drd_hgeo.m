function [X, Dx, discr] = Kalman_step_3Drd_hgeo(y, X_prev, Dx, dt, sigma_n, D_ksi, config, h_geo, sigma_h)
    % TDoA Kalman with h_geo measurements
    % X = [x vx ax y vy ay z vz az]
    nums = find(y ~= 0);
    posts = config.posts(:,nums);
    y = y(nums);
    N = length(nums);

    D_n = eye(N) * sigma_n^2;
    D_n(N+1,N+1) = sigma_h^2;

    F1 = [1 dt dt^2/2; 0 1 dt; 0 0 1];
    F = zeros(9,9);
    F(1:3,1:3) = F1;
    F(4:6,4:6) = F1;
    F(7:9,7:9) = F1;

    G = zeros(9,3);
    G(3,1) = dt;
    G(6,2) = dt;
    G(9,3) = dt;

    H = zeros(N-1,N);
    H(:,end) = 1;
    for i = 1:N-1
        H(i,i) = -1;
    end
    H(end+1,end+1) = 1;
    
    y = [y;h_geo];

    X_ext = F * X_prev;
    D_x_ext = F * Dx * F' + G * D_ksi * G';
    dS = make_dS(y, X_ext, posts);
    S = make_S(y, X_ext, posts);
    K = D_x_ext * dS' * H' * inv(H*dS*D_x_ext*dS'*H' + H*D_n*H');
    Dx = D_x_ext - K * H * dS * D_x_ext;
    discr = H*y - H*S;
    X = X_ext + K*(discr);
end

function dS = make_dS(y, X, posts)
    Rz = 6371e3;
    dS = zeros(length(y),length(X));
    for i = 1:length(y)-1
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2);
        dS(i,1) = (X(1,1) - posts(1,i))/d;
        dS(i,4) = (X(4,1) - posts(2,i))/d;
        dS(i,7) = (X(7,1) - posts(3,i))/d;
    end
    dS(end,1) = X(1,1)/sqrt((Rz + X(7,1))^2 + X(1,1)^2 + X(4,1)^2);
    dS(end,4) = X(4,1)/sqrt((Rz + X(7,1))^2 + X(1,1)^2 + X(4,1)^2);
    dS(end,7) = (Rz + X(7,1))/sqrt((Rz + X(7,1))^2 + X(1,1)^2 + X(4,1)^2);
end

function S = make_S(y, X, posts)
    Rz = 6371e3;
    S = zeros(length(y),1);
    for i = 1:length(y)-1
        S(i,1) = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2);
    end
    S(end,1) = -Rz + sqrt((Rz + X(7,1))^2 + X(1,1)^2 + X(4,1)^2);
end

