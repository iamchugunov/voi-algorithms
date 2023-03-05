function [X, Dx, ud] = Kalman_step_3Drd_Accum9(poits, X_prev, Dx, sigma_n, D_ksi, config, T)
    F1 = [1 T T^2/2; 0 1 T; 0 0 1];
    F = zeros(9,9);
    F(1:3,1:3) = F1;
    F(4:6,4:6) = F1;
    F(7:9,7:9) = F1;

    G = zeros(9,3);
    G(3,1) = T;
    G(6,2) = T;
    G(9,3) = T;
    
    X_ext = F * X_prev;
    D_x_ext = F * Dx * F' + G * D_ksi * G';

    [ud, Dx] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config);
    X = X_ext + Dx * ud;
end
%%
function [ud, Dx] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config)
    t_last = poits(end).Frame;
    W = zeros(9,9);
    ud = zeros(9,1);
    for i = 1:length(poits)
        dt = poits(i).Frame-t_last;
        F1 = [1 dt dt^2/2; 0 1 dt; 0 0 1];
        F = zeros(9,9);
        F(1:3,1:3) = F1;
        F(4:6,4:6) = F1;
        F(7:9,7:9) = F1;
        X_ = F * X_ext;
        y = poits(i).ToA * config.c_ns;
        [w, ud_] = make_w_ud(y, X_, config.posts, sigma_n, dt);
        W = W + w;
        ud = ud + ud_;
    end
    Dx = inv(inv(D_x_ext) + W);
end
%%
function [w, ud, d] = make_w_ud(y, X, posts, sigma_n, dt)
    nums = find(y ~= 0);
    posts = posts(:,nums);
    y = y(nums);
    N = length(nums);
    S = [];
    dS = [];
    for i = 1:length(nums)
        S(i,1) = norm(X([1 4 7],:) - posts(:,i));
        dsdx = (X(1,1) - posts(1,i))/S(i,1);
        dsdy = (X(4,1) - posts(2,i))/S(i,1);
        dsdz = (X(7,1) - posts(3,i))/S(i,1);
        dS(i,:) = [dsdx dsdx*dt dsdx*dt^2/2 dsdy dsdy*dt dsdy*dt^2/2 dsdz dsdz*dt dsdz*dt^2/2];
    end
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
            HDnHT = 2 ;
            HDnHTrev = inv(HDnHT);
    end 
    w = dS' * H' * HDnHTrev * H * dS;
    ud = dS' * H' * HDnHTrev * (H*y - H*S); 
end