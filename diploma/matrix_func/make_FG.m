function [F, G] = make_FG(dt)
    F1 = [1 dt dt^2/2; 0 1 dt; 0 0 1];
    F = zeros(9,9);
    F(1:3,1:3) = F1;
    F(4:6,4:6) = F1;
    F(7:9,7:9) = F1;

    G = zeros(9,3);
    G(3,1) = dt;
    G(6,2) = dt;
    G(9,3) = dt;
end