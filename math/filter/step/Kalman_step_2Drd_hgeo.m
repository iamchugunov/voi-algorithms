function [X, Dx, discr] = Kalman_step_2Drd_hgeo(y, X_prev, Dx, dt, sigma_n, D_ksi, config, h_geo)
    % TDoA Kalman with known h_geo
    % X = [x vx ax y vy ay]
    nums = find(y ~= 0);
    posts = config.posts(:,nums);
    y = y(nums);
    N = length(nums);

    D_n = eye(N) * sigma_n^2;

    F1 = [1 dt dt^2/2; 0 1 dt; 0 0 1];
    F = zeros(6,6);
    F(1:3,1:3) = F1;
    F(4:6,4:6) = F1;

    G = zeros(6,2);
    G(3,1) = dt;
    G(6,2) = dt;

    H = zeros(N-1,N);
    H(:,end) = 1;
    for i = 1:N-1
        H(i,i) = -1;
    end

    X_ext = F * X_prev;
    D_x_ext = F * Dx * F' + G * D_ksi * G';
    dS = make_dS(y, X_ext, posts, h_geo);
    S = make_S(y, X_ext, posts, h_geo);
    K = D_x_ext * dS' * H' * inv(H*dS*D_x_ext*dS'*H' + H*D_n*H');
    Dx = D_x_ext - K * H * dS * D_x_ext;
    discr = H*y - H*S;
    X = X_ext + K*(discr);
end

function dS = make_dS(y, X, posts, h_geo)
    Rz = 6371e3;
    z = -Rz + sqrt((Rz + h_geo)^2 - X(1,1)^2 - X(4,1)^2);
    dS = zeros(length(y),length(X));
    for i = 1:length(y)
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (z - posts(3,i))^2);
        dzdx = -X(1,1)/sqrt((Rz + h_geo)^2 - X(1,1)^2 - X(4,1)^2);
        dS(i,1) = 1/d * (X(1,1) - posts(1,i) + (z - posts(3,i))*dzdx );
        dzdy = -X(4,1)/sqrt((Rz + h_geo)^2 - X(1,1)^2 - X(4,1)^2);
        dS(i,4) = 1/d * (X(4,1) - posts(2,i) + (z - posts(3,i))*dzdy );
    end
end

function S = make_S(y, X, posts, h_geo)
    Rz = 6371e3;
    z = -Rz + sqrt((Rz + h_geo)^2 - X(1,1)^2 - X(4,1)^2);
    S = zeros(length(y),1);
    for i = 1:length(y)
        S(i,1) = sqrt((X(1,1) - posts(1,i))^2 + (X(4,1) - posts(2,i))^2 + (z - posts(3,i))^2);
    end
end

