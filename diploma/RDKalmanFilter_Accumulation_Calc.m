function [X, Dx_hist, discr] = RDKalmanFilter_Accumulation_Calc(poits, X_prev, Dx, sigma_n, D_ksi, config, T)
    % TDoA Kalman
    % X = [x vx ax y vy ay z vz az]
    Ud = zeros(9,1);
    
     %dt = poits(i).Frame - poits(end).Frame;
     % тут нужен цикл для прогонки по вошедшим отметкам
     k = 0;
     k0 = 1;
     Td = poits(1).Frame; % начало периода дискретизации
     for i = 1:length(poits)
         k = k + 1;
         if poits(i).Frame - Td > T
             Td = poits(i).Frame; % окончание периода дискритизации

             % нужно сделать оценку X и Dx, а так же экстраполяцию на
             % отметки внутри периода дискретизации
             y = poits(i).ToA*config.c_ns;
             [posts, y, H, HDnHTrev] = RemoveZeroPosts_makeH_HDnHTrev(y, sigma_n, config);

             [F, G] = make_FG(T);
             % оценка вектора состояния и матрицы дисперсий
             X_ext_Td = F * X_prev;
             D_x_ext_Td = F * Dx * F' + G * D_ksi * G';

             dS_Td = make_dS(y, X_ext_Td, posts);
             S_Td = make_S(y, X_ext_Td, posts);
             Dx_Td = inv(inv(D_x_ext_Td) - dS_Td' * H' * HDnHTrev * H * dS_Td);
             K_Td = Dx_Td * dS_Td' * H' * HDnHTrev;

             discr_Td = H*y - H*S_Td;
             X_Td = X_ext_Td + K_Td*discr_Td;
             

             for j = k0:(k-1)
                 y = poits(j).ToA*config.c_ns;
                 [posts, y, H, HDnHTrev] = RemoveZeroPosts_makeH_HDnHTrev(y, sigma_n, config);
                 dt = poits(j).Frame - poits(k).Frame;
                 [F, G] = make_FG(dt);

                 X_ext = F * X_ext_Td;
                 D_x_ext = F * Dx * F' + G * D_ksi * G';

                 dS = make_dS(y, X_ext, posts);
                 S = make_S(y, X_ext, posts);
                 Dx = inv(inv(D_x_ext) - dS' * H' * HDnHTrev * H * dS);
                 K = Dx * dS' * H' * HDnHTrev;

                 discr(:,j) = H*y - H*S;
                 X(:,j) = X_ext + K*discr(:,j);
                 Dx_hist(:,j) = diag(Dx);
             end
             X(:,k) = X_Td;
             discr(:,k) =  discr_Td;
             Dx_hist(:,k) = diag(Dx_Td);

             k0 = k + 1;
         end
     end 


%         Ud_ = dS' * H' * inv(HDnHTrev) * H * dS;
        
%         X(:,i) = X_ext + Dx * Ud;

    
     
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


function [posts, y, H, HDnHTrev] = RemoveZeroPosts_makeH_HDnHTrev(y, sigma_n, config)
    nums = find(y ~= 0);
    posts = config.posts(:,nums);
    y = y(nums);
    N = length(nums);

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
end



function [F, G] = make_FG(dt)
    F1 = [1 dt dt^2/2; 0 1 dt; 0 0 1];
    F = zeros(9,9);
    F(1:3,1:3) = F1;
    F(4:6,4:6) = F1;
    F(7:9,7:9) = F1;

    G = zeros(9,3);
    G(3,1) = dt;
    G(6,2) = dt;
    G(9,3) = dt;
end
