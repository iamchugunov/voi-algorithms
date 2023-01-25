function [X, Dx, discr] = Kalman_step_3Drd_0(y, X_prev, Dx, dt, sigma_n, D_ksi, config)
    % TDoA Kalman
    % X = [x y z]
    nums = find(y ~= 0);
    posts = config.posts(:,nums);
    y = y(nums);
    N = length(nums);

    D_n = eye(N) * sigma_n^2;

    F = eye(3);
    G = eye(3) * dt;

    H = zeros(N-1,N);
    H(:,end) = 1;
    for i = 1:N-1
        H(i,i) = -1;
    end

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
    dS = zeros(length(y),length(X));
    for i = 1:length(y)
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(2,1) - posts(2,i))^2 + (X(3,1) - posts(3,i))^2);
        dS(i,1) = (X(1,1) - posts(1,i))/d;
        dS(i,2) = (X(2,1) - posts(2,i))/d;
        dS(i,3) = (X(3,1) - posts(3,i))/d;
    end
end

function S = make_S(y, X, posts)
    S = zeros(length(y),1);
    for i = 1:length(y)
        S(i,1) = sqrt((X(1,1) - posts(1,i))^2 + (X(2,1) - posts(2,i))^2 + (X(3,1) - posts(3,i))^2);
    end
end

