function [config] = Config()
%����
%% общие параметры
    config.c = 299792458;
    config.c_ns = config.c/1e9;
%% координаты постов
    R = 10e3; %% расстояние между постами
    posts = [];
    hp = 15;
    alphap = [30 150 270]*pi/180;
    for i = 1:3
        posts(:,i) = [R * cos(alphap(i)); R * sin(alphap(i)); hp + normrnd(0, 5)];
    end
    posts(:,4) = [0;0;hp];
%     posts = [-5e3 -5e3 5e3 5e3; -5e3 5e3 -5e3 5e3; 100 100 100 100];
    config.posts = posts;
    
%% центральная точка
    BLHref = [30.097498; 30.962812; 0]; % Cairo

%% погрешность измерений
    config.sigma_n_ns = 20;
    
end

