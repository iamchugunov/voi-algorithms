function [X, Dx, ud] = Kalman_step_3Drd_Accum6(poits, X_prev, Dx, sigma_n, D_ksi, config, T)
    F = eye(6,6);
    F(1,2) = T;
    F(3,4) = T;
    F(5,6) = T;
    G = zeros(6,3);
    G(2,1) = T;
    G(4,2) = T;
    G(6,3) = T;
    
    X_ext = F * X_prev;
    D_x_ext = F * Dx * F' + G * D_ksi * G';

    [ud, Dx] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config);
    X = X_ext + Dx * ud;
end
%%
function [ud, Dx, discr] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config)
    t_last = poits(end).Frame;
    W = zeros(6,6);
    ud = zeros(6,1);
    discr = [];
    for i = 1:length(poits)
        dt = poits(i).Frame-t_last;
        F = eye(6,6);
        F(1,2) = dt;
        F(3,4) = dt;
        F(5,6) = dt;

        X_ = F * X_ext;
        y = poits(i).ToA * config.c_ns;
        [w, ud_] = make_w_ud(y, X_, config.posts, sigma_n, dt);
        W = W + w;
        ud = ud + ud_;
  
    end
    
    Dx = inv(inv(D_x_ext) + W);
end
%%
function [w, ud] = make_w_ud(y, X, posts, sigma_n, dt)
    nums = find(y ~= 0);
    posts = posts(:,nums);
    y = y(nums);
    N = length(nums);

    S = [];
    dS = [];
    for i = 1:length(nums)
        S(i,1) = norm(X([1 3 5],:) - posts(:,i));
        dsdx = (X(1,1) - posts(1,i))/S(i,1);
        dsdy = (X(3,1) - posts(2,i))/S(i,1);
        dsdz = (X(5,1) - posts(3,i))/S(i,1);
        dS(i,:) = [dsdx dsdx*dt dsdy dsdy*dt dsdz dsdz*dt];
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