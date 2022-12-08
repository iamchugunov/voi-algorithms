function [poit] = crd_calc3a(poit, config)
    
    pd = poit.ToA * config.c_ns;
    nms = find(pd);
    
    posts = config.posts(:,nms);
    toa = pd(nms);
    Z = poit.true_crd(3);
    res = solver_analytical_2D_3_posts_h(toa, posts, Z);
    poit.res = res;
    if res.N == 2
        
    elseif res.N == 1
        
    else
        
    end
end

