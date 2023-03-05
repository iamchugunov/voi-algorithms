%% track
clear all
close all
config = Config();
traj_params.X0 = [50e3; -50e3]; 
traj_params.V = 0*200; 
traj_params.kurs = 135; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 600]; 

traj_params.track_id = 0;

% traj_params.maneurs(1) = struct('t0',100,'t',200,'acc',0,'omega',0.6);
% traj_params.maneurs(2) = struct('t0',300,'t',400,'acc',0,'omega',-0.3);
% traj_params.maneurs(3) = struct('t0',500,'t',600,'acc',0.5,'omega',0);

% traj_params.maneurs(1) = struct('t0',1,'t',600,'acc',0,'omega',0.6);
traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
%% thinning track
% params.mode = 0;
% params.percentage = [0 0.5 0.5];
% params.banned_post = 2;
% [track.poits, res] = thinning_measurements(track.poits, params, config);
%%
paramsT.T_nak = 30;
paramsT.T = 5;

nms = find([track.t] < paramsT.T);

X0 = [track.crd(1,nms(end));
      track.crd(2,nms(end));
      track.crd(3,nms(end));];
sigma_Dx0 = 1;
Dx0 = sigma_Dx0*eye(3,3); 
s_ksi = 1;


Filter = RDKF_Accum(track, config, s_ksi, X0, Dx0, paramsT);

show_posts2D
show_track2D(track)
hold on
plot(Filter.crd(1,:)/1000,Filter.crd(2,:)/1000, "r-")
figure
plot(track.t,track.crd(3,:))
hold on
plot(Filter.t,Filter.crd(3,:))
figure
plot(track.t, track.crd(1,:) )
hold on
plot(Filter.t, Filter.crd(1,:))
%%
function [KFilter] = RDKF_Accum(track, config, s_ksi, ...
    X0, Dx0, params_disk)

    poits = track.poits;
    s_n = config.c_ns * config.sigma_n_ns;
    D_ksi = eye(3,3) * s_ksi^2;
    Dx = Dx0;
    X_prev = [X0(1); X0(2); X0(3);];
    T = params_disk.T;
    T_nak = params_disk.T_nak;

    t = [];
  
    discr = [];

    t_res_last = poits(1).Frame;
    k = 0;
%     X(:,1) = X_prev;
    for i = 1:length(poits)
        if poits(i).Frame - t_res_last > T
            k = k + 1;
            
            current_poits = poits(i);
            k1 = 0;
            for j = 1:i
                if poits(i).Frame - poits(j).Frame < T_nak
                    k1 = k1 + 1;
                    current_poits(k1) = poits(j);
                end
            end
            
            dt = current_poits(end).Frame - t_res_last;
%             [dt length(current_poits)]
            [X, Dx, d] = RDKF_step(current_poits, X_prev, Dx, s_n, D_ksi, config, dt);
            t_res_last = poits(i).Frame;
            t(k) = t_res_last;
            discr = [discr d];
            
           
            X_prev = X;
            Xnak(:,k) = X;
        end
        
    end

    KFilter.X = Xnak;
    KFilter.crd = Xnak([1 2 3],:);
%     KFilter.vel = Xnak([2 5 8],:);
%     KFilter.acc = Xnak([3 6 9],:);
    KFilter.Dx = Dx;
    KFilter.t = t;
    KFilter.discr = discr;
end
%%
function [X, Dx, ud] = RDKF_step(poits, X_prev, Dx, sigma_n, D_ksi, config, T)
    F = eye(3,3);
    G = T*eye(3,3);
    

    X_ext = F * X_prev;
    D_x_ext = F * Dx * F' + G * D_ksi * G';

    [ud, Dx, d] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config);
    X = X_ext + Dx * ud;
end
%%
function [ud, Dx, discr] = make_ud_Dx(poits, X_ext, D_x_ext, sigma_n, config)
    t_last = poits(end).Frame;
    W = zeros(3,3);
    ud = zeros(3,1);
    discr = [];
    for i = 1:length(poits)
        dt = poits(i).Frame-t_last;
        F = eye(3,3);
        X_ = F * X_ext;
        y = poits(i).ToA * config.c_ns;
        nms = find(y ~= 0);

%         for j = 1:length(nms)
%             w = make_w_second(X_, config.posts(:,nms(j)));
            w = make_w(y, X_, config.posts, sigma_n);
            W = W + w;
%         end
        [ud_, d] = make_ud(y, X_, config.posts, sigma_n);
        ud = ud + ud_;
        discr = [discr d];
    end
    
    Dx = inv(inv(D_x_ext) + W);
end
%%
% function [w] = make_w(X, post)
%     d = norm(X([1 2 3],1) - post);
%     dSdx = (X(1,1) - post(1))/d;
%     dSdy = (X(2,1) - post(2))/d;
%     dSdz = (X(3,1) - post(3))/d;
% 
% 
%     w = [dSdx*dSdx dSdx*dSdy  dSdx*dSdz;
%          dSdy*dSdx dSdy*dSdy  dSdy*dSdz;
%          dSdz*dSdx dSdz*dSdy  dSdz*dSdz;];
% end
%%
function [w] = make_w(y, X, posts, sigma_n)
    nums = find(y ~= 0);
    posts = posts(:,nums);
    y = y(nums);
    N = length(nums);

    S = [];
    dS = [];
    for i = 1:length(nums)
        S(i,1) = norm(X([1 2 3],:) - posts(:,nums(i)));
        dsdx = (X(1,1) - posts(1,nums(i)))/S(i,1);
        dsdy = (X(2,1) - posts(2,nums(i)))/S(i,1);
        dsdz = (X(3,1) - posts(3,nums(i)))/S(i,1);
        dS(i,:) = [dsdx  dsdy   dsdz  ];
    end

    H = zeros(N-1,N);
    H(:,end) = 1;
    for i = 1:N-1
        H(i,i) = -1;
    end 

    switch N
        case 4      
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 3
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 2
            HDnHT = 2 ;
            HDnHTrev = inv(HDnHT);
    end
    
    w = dS' * H' * HDnHTrev * H * dS;
end
%%
function [ud, d] = make_ud(y, X, posts, sigma_n)
    nums = find(y ~= 0);
    posts = posts(:,nums);
    y = y(nums);
    N = length(nums);

    H = zeros(N-1,N);
    H(:,end) = 1;
    for i = 1:N-1
        H(i,i) = -1;
    end 

    switch N
        case 4      
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 3
            HDnHT = sigma_n^2 * H * H';
            HDnHTrev = inv(HDnHT);
        case 2
            HDnHT = 2 * sigma_n^2;
            HDnHTrev = inv(HDnHT);
    end
    
    S = [];
    dS = [];
    for i = 1:length(nums)
        S(i,1) = norm(X([1 2 3],:) - posts(:,nums(i)));
        dsdx = (X(1,1) - posts(1,nums(i)))/S(i,1);
        dsdy = (X(2,1) - posts(2,nums(i)))/S(i,1);
        dsdz = (X(3,1) - posts(3,nums(i)))/S(i,1);
        dS(i,:) = [dsdx  dsdy  dsdz ];
    end

    ud = dS' * H' * HDnHTrev * (H*y - H*S);
    d = (H*y - H*S);
    

end

