function [res] = mnk_pdm2D(y, posts, z, mnk_params)

    epsilon = mnk_params.epsilon;
    max_iter = mnk_params.max_iter;
    X0 = mnk_params.X0;
    dt_threshold = mnk_params.nev_threshold;
    R_max = mnk_params.R_max;
    
    res = [];
    res.flag = 0;
    res.norm_nev = [];
    res.nev = [];
    res.iter = 0;
    res.X = [];
    res.dop = [];
    res.dt = [];
    res.norm_dt = [];
    
    N = size(posts,2);
    Y = zeros(3, 1);
    H = zeros(N, 3);
    X = X0;
    
    iter = 0;
    
while 1
    
    iter = iter + 1;
    
    for i = 1:N
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(2,1) - posts(2,i))^2 + (z - posts(3,i))^2);
        Y(i, 1) = d + X(3,1);
        H(i, 1) = (X(1,1) - posts(1,i))/d;
        H(i, 2) = (X(2,1) - posts(2,i))/d;
        H(i, 3) = 1;
    end
    
    X_prev = X;
    X = X + (H'*H)^(-1)*(H')*(y-Y);
    nev = norm(X - X_prev);
    
    res.norm_nev(iter) = nev;
    res.nev(:,iter) = X - X_prev;
    
    if (nev < epsilon) || (iter > max_iter) 
        
        if nev > 1e8 || norm(X(1:2)) > R_max
            res.flag = 0;
        else
            res.flag = 1;
            invHH = inv(H'*H);
            res.X = X;
            res.dop.XDOP = sqrt(abs(invHH(1,1)));
            res.dop.YDOP = sqrt(abs(invHH(2,2)));
            res.dop.TDOP = sqrt(abs(invHH(3,3)));
            res.dop.HDOP = norm([res.dop.XDOP res.dop.YDOP]);
            res.dop.PDOP = norm([res.dop.XDOP res.dop.YDOP]);
            dt = (y - Y);
            res.dt = dt;
            res.norm_dt = norm(dt);
            if norm(dt) > dt_threshold
                res.flag = 0;
            else
                res.flag = 1;
            end
        end
        break
    end
end

end

