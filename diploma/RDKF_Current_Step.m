function [Ud] = RDKF_Current_Step(poits, X_prev, Dx, Td, sigma_n, D_ksi, config)
% эта функция отвечает за реализацию накопления в рамках одного шага
% фильтра Калмана, входными параметрами помимо набора отметок, конфига и
% дисперсий шума наблюдени являются экстраполированные координаты и
% дисперисия на момент окончания одного шага Калмана/интервала дискретизации
Ud = zeros(9,1);
    for i = 1:length(poits)
        
        y = poits(i).ToA*config.c_ns;
        [posts, y, H, HDnHTinv] = RZPamdMakeHmatrix(y, sigma_n, config);

        dt = poits(i).Frame - Td;

        [F, G] = make_FG(dt);
             
        X_ext = F * X_prev;
        D_x_ext = F * Dx * F' + G * D_ksi * G';

        dS = make_dS(y, X_ext, posts);
        S = make_S(y, X_ext, posts);
        Dx = inv(inv(D_x_ext) - dS' * H' * HDnHTinv * H * dS);
%         K = Dx * dS' * H' * HDnHTinv;
        Ud_ = dS' * H' * HDnHTinv * H *dS;
        Ud = Ud + Ud_;


    end 
end