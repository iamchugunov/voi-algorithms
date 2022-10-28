function [] = show_hyperb_poits(poits, config)
    toa = [];
    for i = 1:length(poits)
        toa(:,i) = poits(i).ToA * config.c_ns;
    end
    show_hyperbols(toa, config.posts, poits(1).true_crd(3), 4)
end

