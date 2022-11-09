function [poit] = crd_calc(poit, config)
    
    pd = poit.ToA * config.c_ns;
    mnk_params.epsilon = 0.001;
    mnk_params.max_iter = 20;
    mnk_params.X0 = [1000;1000;5000;0];
    mnk_params.nev_threshold = 1;
    mnk_params.R_max = 500e3;
    
    
    res = mnk_pdm3D(pd, config.posts, mnk_params);
    poit.res = res;
    if res.flag
        poit.crd_valid = 1;
        poit.est_crd = res.X(1:3);
        poit.est_ToT = res.X(4)/config.c + poit.Frame;
    end
end

