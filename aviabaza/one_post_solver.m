function [X] = one_post_solver(y, P, sigma_r, sigma_h, X0)


iter = 0;

W = eye(3);
W(1,1) = 1/sigma_r^2;
W(2,2) = 1/sigma_r^2;
W(3,3) = 1/sigma_h^2;

epsilon = 0.001;
max_iter = 30;

X = X0;

while 1
    
    iter = iter + 1;
    
    d1 = norm(X - P(:,1));
    d2 = norm(X - P(:,2));
    
    H(1,:) = (X - P(:,1))'/d1;
    H(2,:) = (X - P(:,2))'/d2;
    H(3,:) = [0 0 1];
    
    Y = [d1; d2; X(3)];
    
    X_prev = X;
    X = X + (H'*W*H)^(-1)*(H')*W*(y - Y);
    nev = norm(X - X_prev);
    
    if (nev < epsilon) || (iter > max_iter)
        
        if nev > 1e8
            flag = 0;
        else
            flag = 1;
        end
        break
    end
end
end

