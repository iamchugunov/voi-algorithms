function [traj] = matching_main(poits, config)
   
    k = 0;

    for i = 1:length(poits)

        % рассчитываем координаты точки одномоментным способом
        % проверяем рассчитались ли координаты
        % если нет - точка в помойку
        match_flag = 0;

        for j = 1:k
            if (is_match_traj(traj(j), poits(i), config))
                traj(j) = add_poit_to_traj(traj(j),poits(i),config);
                match_flag = 1;
                break
            end
        end

        if (match_flag)
            continue
        end

        new_traj_ = new_traj(poits(i), config);
        k = k + 1;
        traj(k) = new_traj_;

    end
end