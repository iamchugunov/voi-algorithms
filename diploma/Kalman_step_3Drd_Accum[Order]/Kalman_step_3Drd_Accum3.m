function [X, Dx, ud] = Kalman_step_3Drd_Accum3(poits, X_prev, Dx, sigma_n, D_ksi, config, T)
    F = eye(3,3);
    G = T*eye(3,3);
    X_ext = F * X_prev;
    D_x_ext = F * Dx * F' + G * D_ksi * G';

    [ud, Dx] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config);
    X = X_ext + Dx * ud;
end
%%
function [ud, Dx] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config)
    t_last = poits(end).Frame;
    W = zeros(3,3);
    ud = zeros(3,1);
    for i = 1:length(poits)
        dt = poits(i).Frame-t_last;
        F = eye(3,3);
        X_ = F * X_ext;
        y = poits(i).ToA * config.c_ns;
        nms = find(y ~= 0);
        [w, ud_] = make_w_ud(y, X_, config.posts, sigma_n);
        W = W + w;
        ud = ud + ud_;
    end
    
    Dx = inv(inv(D_x_ext) + W);
end

%%
function [w, ud] = make_w_ud(y, X, posts, sigma_n)
    nums = find(y ~= 0);
    posts = posts(:,nums);
    y = y(nums);
    N = length(nums);

    S = [];
    dS = [];
    for i = 1:length(nums)
        S(i,1) = norm(X([1 2 3],:) - posts(:,i));
        dsdx = (X(1,1) - posts(1,i))/S(i,1);
        dsdy = (X(2,1) - posts(2,i))/S(i,1);
        dsdz = (X(3,1) - posts(3,i))/S(i,1);
        dS(i,:) = [dsdx  dsdy   dsdz  ];
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

