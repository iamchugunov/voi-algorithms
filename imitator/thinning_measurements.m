function [poits, res] = thinning_measurements(poits, params, config)
    % функция предназначена для прореживания измерений - формирования
    % двоек, троек, четверок
    % есть два режима mode: 
    % mode=0 - равномерное распределение
    % mode=1 - исключения одного поста полностью
    % percentage - процентное соотношение двоек/троек/четверок
    % сумма должна быть равна 1
    % пример percentage [0.5 0.4 0.1];
    % banned_post - номер выключенного поста для режима 1
    mode = params.mode;
    percentage = params.percentage;
    banned_post = params.banned_post;
    for i = 1:length(poits)
        switch mode
            case 0
                rand_number = rand;
                if rand_number < percentage(1)
                    N1 = randi([1 4]);
                    N2 = randi([1 4]);
                    while N1 == N2
                        N2 = randi([1 4]);
                    end
                    poits(i).ToA([N1 N2]) = 0;
                    poits(i).count = 2;
                elseif rand_number < percentage(1) + percentage(2)
                    poits(i).ToA(randi([1 4])) = 0;
                    poits(i).count = 3;
                else
                    poits(i).count = 4;
                end                
            case 1
                poits(i).ToA(banned_post) = 0;
                poits(i).count = 3;
        end
        
        poits(i).rd = zeros(6,1);
        poits(i).rd_flag = zeros(6,1);
        rd = [4 1; 4 2; 4 3; 3 1; 3 2; 2 1];
        for j = 1:6
            if poits(i).ToA(rd(j,1)) > 0 && poits(i).ToA(rd(j,2)) > 0
                poits(i).rd(j,1) = (poits(i).ToA(rd(j,1)) - poits(i).ToA(rd(j,2)))*config.c_ns;
                poits(i).rd_flag(j,1) = 1;
            end
        end
    end
    
    res.percentage(1) = 100 * length(find([poits.count] == 2))/length(poits);
    res.percentage(2) = 100 * length(find([poits.count] == 3))/length(poits);
    res.percentage(3) = 100 * length(find([poits.count] == 4))/length(poits);
    
    
end

