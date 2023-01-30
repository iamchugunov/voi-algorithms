function [X] = all_post_solver(y, P, sigma_r, sigma_h, X0)


iter = 0;

W = eye(12);
W(1,1) = 1/sigma_r^2;
W(2,2) = 1/sigma_r^2;
W(3,3) = 1/sigma_r^2;
W(4,4) = 1/sigma_r^2;
W(5,5) = 1/sigma_r^2;
W(6,6) = 1/sigma_r^2;
W(7,7) = 1/sigma_r^2;
W(8,8) = 1/sigma_r^2;
W(9,9) = 1/sigma_r^2;
W(10,10) = 1/sigma_h^2;
W(11,11) = 1/sigma_h^2;
W(12,12) = 1/sigma_h^2;

epsilon = 0.001;
max_iter = 30;

X = X0;

while 1
    
    iter = iter + 1;
    
    d1a = norm(X(1:3) - P(:,1));
    d1b = norm(X(1:3) - P(:,2));
    d2a = norm(X(4:6) - P(:,1));
    d2b = norm(X(4:6) - P(:,2));
    d3a = norm(X(7:9) - P(:,1));
    d3b = norm(X(7:9) - P(:,2));
    
    d12 = norm(X(1:3) - X(4:6));
    d13 = norm(X(1:3) - X(7:9));
    d23 = norm(X(4:6) - X(7:9));
    
    H(1,:) = [(X(1:3) - P(:,1))'/d1a 0 0 0 0 0 0];
    H(2,:) = [(X(1:3) - P(:,2))'/d1b 0 0 0 0 0 0];
    H(3,:) = [0 0 0 (X(4:6) - P(:,1))'/d2a 0 0 0];
    H(4,:) = [0 0 0 (X(4:6) - P(:,2))'/d2b 0 0 0];
    H(5,:) = [0 0 0 0 0 0 (X(7:9) - P(:,1))'/d3a];
    H(6,:) = [0 0 0 0 0 0 (X(7:9) - P(:,2))'/d3b];
    H(7,:) = [(X(1:3) - X(4:6))'/d12, -(X(1:3) - X(4:6))'/d12 0 0 0];
    H(8,:) = [(X(1:3) - X(7:9))'/d13, 0 0 0, -(X(1:3) - X(7:9))'/d13];
    H(9,:) = [0 0 0, (X(4:6) - X(7:9))'/d23, -(X(4:6) - X(7:9))'/d23];
    H(10,:) = [0 0 1 0 0 0 0 0 0];
    H(11,:) = [0 0 0 0 0 1 0 0 0];
    H(12,:) = [0 0 0 0 0 0 0 0 1];
    
    Y = [d1a; d1b; d2a; d2b; d3a; d3b; d12; d13; d23; X(3); X(6); X(9)];
    
    X_prev = X;
    X = X + (H'*W*H)^(-1)*(H')*W*(y - Y);
    nev = norm(X - X_prev);
    [nev iter]
    
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

