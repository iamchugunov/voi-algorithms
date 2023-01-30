function [poit] = crd_calc4a(poit, config)
    
    toa = poit.ToA * config.c_ns;
    posts = config.posts;
    res = solver_analytical_3D_4_posts(toa, posts);
    poit.res = res;
    if res.N == 2
        
    elseif res.N == 1
        
    else
        
    end
end

