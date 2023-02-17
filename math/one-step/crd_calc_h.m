function [poit] = crd_calc_h(poit, config, X0)
    
    pd = poit.ToA * config.c_ns;
    nms = find(pd);
    posts = config.posts(:,nms);
    pd = pd(nms);
    
    mnk_params.epsilon = 0.001;
    mnk_params.max_iter = 20;
    mnk_params.X0 = [1000;1000;pd(1)];
    mnk_params.nev_threshold = 500;
    mnk_params.R_max = 500e3;
    mnk_params.h_geo = 10000;
    
    if nargin == 3
        mnk_params.X0 = [X0(1:2); pd(1)];
        mnk_params.h_geo = X0(3);
    end
    
    
    res = mnk_pdm_hgeo_2D(pd, posts, mnk_params);
    poit.res = res;
    if res.flag
        poit.crd_valid = 1;
        poit.est_crd = res.X(1:3);
        poit.est_ToT = res.X(4)/config.c + poit.Frame;
    else
        poit.crd_valid = 0;
    end
end

