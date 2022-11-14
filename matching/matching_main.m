function [traj] = matching_main(poits, config)

k = 0;
for i = 1:length(poits)
    % рассчитываем координаты точки одномоментным способом
    poits(i) = crd_calc(poits(i),config);
    % проверяем рассчитались ли координаты
    if (~poits(i).crd_valid)
        % если нет - точка в помойку
        continue
    end

    match_flag = 0;
    R = is_match_traj(traj, poits(i), config, k);
    if(min(R.poits) < 3*config.sigma_n_ns + poits.h_geo)
        match_flag=1;
    end 

    if (match_flag)
        traj(index(min(R.poits))) = add_poit_to_traj(traj(index),poits(i),config);
        continue
    end

    new_traj_ = new_traj(poits(i), config);
    k = k + 1;
    traj(k) = new_traj_;

end
end