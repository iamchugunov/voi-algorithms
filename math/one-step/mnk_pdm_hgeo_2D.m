function [res] = mnk_pdm_hgeo_2D(y, posts, mnk_params)

    epsilon = mnk_params.epsilon;
    max_iter = mnk_params.max_iter;
    X0 = mnk_params.X0;
    dt_threshold = mnk_params.nev_threshold;
    R_max = mnk_params.R_max;
    h = mnk_params.h_geo;
    
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
    Y = zeros(N, 1);
    H = zeros(N, 3);
    X = X0;
    
    iter = 0;
    
    Rz = 6371e3;
    
while 1
    
    iter = iter + 1;
    
    for i = 1:N
        z = -Rz + sqrt((Rz + h)^2 - X(1,1)^2 - X(2,1)^2);
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(2,1) - posts(2,i))^2 + (z - posts(3,i))^2);
        Y(i, 1) = d + X(3,1);
        dzdx = -X(1,1)/sqrt((Rz + h)^2 - X(1,1)^2 - X(2,1)^2);
        H(i, 1) = 1/d * (X(1,1) - posts(1,i) + (z - posts(3,i))*dzdx );
        dzdy = -X(2,1)/sqrt((Rz + h)^2 - X(1,1)^2 - X(2,1)^2);
        H(i, 2) = 1/d * (X(2,1) - posts(2,i) + (z - posts(3,i))*dzdy );
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
            res.X = [X(1:2); z; X(3)];
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

