function [poit] = crd_calc3(poit, config)
    
    pd = poit.ToA * config.c_ns;
    nms = find(pd);
    posts = config.posts(:,nms);
    toa = pd(nms);

    mnk_params.epsilon = 0.001;
    mnk_params.max_iter = 20;
    mnk_params.X0 = [1000;1000;pd(1)];
    mnk_params.nev_threshold = 1;
    mnk_params.R_max = 500e3;
    
%     z = 10000;
    z = poit.true_crd(3);
    res = mnk_pdm2D(toa, posts, z, mnk_params);
    poit.res = res;
    if res.flag
        poit.crd_valid = 1;
        poit.est_crd = [res.X(1:2); z];
        poit.est_ToT = res.X(3)/config.c + poit.Frame;
    else
        poit.crd_valid = 0;
    end
end

