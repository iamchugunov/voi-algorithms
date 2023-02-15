function [X, d, Dx_hist, Dx] = RDKF_Accum_Calc(poits, X_prev, Dx, sigma_n, D_ksi, config, T)
    % TDoA Kalman
    % X = [x vx ax y vy ay z vz az]
    Ud_nak = zeros(9,1);
    [F, G] = make_FG(T);
    
     Td = poits(1).Frame; % начало периода дискретизации
     % надо в новую переменную закинуть отметки одного шага Калмана для
     % экстраполяции и накопления
     k = 0;
     for i = 1:length(poits)
        
         if poits(i).Frame - Td > T
             k = k + 1;
             Td = poits(i).Frame; % окончание периода дискритизации
            
             
             y = poits(i).ToA*config.c_ns;
             [posts, y, H, HDnHTinv] = RZPandMakeHmatrix(y, sigma_n, config);

             X_ext = F * X_prev;
             D_x_ext = F * Dx * F' + G * D_ksi * G';

             dS = make_dS(y, X_ext, posts);
             S = make_S(y, X_ext, posts);
             Dx = inv(inv(D_x_ext) - dS' * H' * HDnHTinv * H * dS);
             K = Dx * dS' * H' * HDnHTinv;
             discr = H*y - H*S;

             Ud = RDKF_Current_Step(One_step_poits, X_ext, D_x_ext, Td, sigma_n, D_ksi, config);
             Ud_nak = Ud + Ud_nak;

%              X(:,k) = X_ext + K*discr;
             X(:,k) = X_ext + Dx*Ud_nak;
             d(:,k) = discr;
             Dx_hist(:,k) = diag(Dx);

              

             X_prev = X(:,k);
             count = poits(i+1);
         end
     end
end
  

