function [X, Dx, discr] = Kalman_step_3Dpd_T(y, X_prev, Dx, dt, sigma_n, D_ksi, config)
    % pd-kalman with knonw dT X = [x vx ax y vy ay z vz az tot]
    nums = find(y ~= 0);
    posts = config.posts(:,nums);
    y = y(nums);
    N = length(nums);

    D_n = eye(N) * sigma_n^2;

    F1 = [1 dt dt^2/2; 0 1 dt; 0 0 1];
    F = zeros(9,9);
    F(1:3,1:3) = F1;
    F(4:6,4:6) = F1;
    F(7:9,7:9) = F1;
    F(10,10) = 1;
    B = zeros(10,1);
    B(10) = config.c;

    G = zeros(10,3);
    G(3,1) = dt;
    G(6,2) = dt;
    G(9,3) = dt;

    X_ext = F * X_prev + B * dt;
    D_x_ext = F * Dx * F' + G * D_ksi * G';
    dS = make_dS(y, X_ext, posts);
    S = make_S(y, X_ext, posts);
    K = D_x_ext * dS' * inv(dS*D_x_ext*dS' + D_n);
    Dx = D_x_ext - K * dS * D_x_ext;
    discr = y - S;
    X = X_ext + K*(discr);
end

function dS = make_dS(y, X, posts)
    dS = zeros(length(y),length(X));
    for i = 1:length(y)
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2);
        dS(i,1) = (X(1,1) - posts(1,i))/d;
        dS(i,4) = (X(4,1) - posts(2,i))/d;
        dS(i,7) = (X(7,1) - posts(3,i))/d;
        dS(i,10) = 1;
    end
end

function S = make_S(y, X, posts)
    S = zeros(length(y),1);
    for i = 1:length(y)
        S(i,1) = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (X(7,1) - posts(3,i))^2) + X(10, 1);
    end
end



