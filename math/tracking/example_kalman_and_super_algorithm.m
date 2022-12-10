%%
clear all
close all
config = Config();
traj_params.X0 = [50e3; -50e3]; 
traj_params.V = 200; 
traj_params.kurs = 120; 
traj_params.h = 10e3; 
traj_params.time_interval = [0 600]; 
traj_params.track_id = 0;

traj_params.maneurs(1) = struct('t0',100,'t',200,'acc',0,'omega',0.6);
traj_params.maneurs(2) = struct('t0',300,'t',400,'acc',0,'omega',-0.3);
traj_params.maneurs(3) = struct('t0',500,'t',600,'acc',0.5,'omega',0);

%traj_params.maneurs(1) = struct('t0',1,'t',600,'acc',0,'omega',0.6);
%traj_params.maneurs = [];
track = make_geo_track_new(traj_params, config);
measurements_params.sigma_n_ns = config.sigma_n_ns;
measurements_params.period_sec = 0.1;
measurements_params.n_periods = 0;
measurements_params.strob_dur = 0.12;
measurements_params.s_ksi = 0;
track = make_measurements_for_track(track, measurements_params, config);
disp("Track work")
  %%
  sigma_ksi = 1;
  X0 = [track.poits(1).true_crd(1,1); 
        track.poits(1).true_vel(1,1); 
        track.poits(1).true_crd(2,1); 
        track.poits(1).true_vel(2,1); 
        track.poits(1).true_crd(3,1); 
        track.poits(1).true_vel(3,1);];
  KFilter_res_rd = RDKalmanFilter3D(track, config, X0, sigma_ksi);
  process_params.T_nak = 30;
  process_params.T_res = 5;
  process_params.abc = [0.1 0.1 0.5]; % circle 1 0.1 0.1~ 
                                      
  
  
 [t, X, Xf] = process_track(track, config, process_params);

  for i = 1:length(track.poits)
    track.poits(i) = crd_calc(track.poits(i),config);
  end
  X_true = true_params(track,t);
  figure
  show_posts2D
  show_primary_points2D(track.poits)
  plot(KFilter_res_rd.X(1,:)/1000,KFilter_res_rd.X(4,:)/1000,'r.-')
  plot(Xf(1,:)/1000,Xf(4,:)/1000,'b.-')
  show_track2D(track)
  
  err_x_rd = KFilter_res_rd.X([1 4 7],:) - [track.poits.true_crd];
  err_v_rd = KFilter_res_rd.X([2 5 8],:) - [track.poits.true_vel];
  err_x_ab = Xf([1 4 7],:) - X_true([1 4 7],:);
  err_v_ab = Xf([2 5 8],:) - X_true([2 5 8],:);
  
  %{
  figure
  plot(KFilter_res_rd.t,3*sqrt(KFilter_res_rd.Dx(1,:)))
  hold on
  plot([track.poits.Frame],err_x_rd(1,:),'.-')
  %}
  
  figure
  subplot(2,1,1)
  plot(KFilter_res_rd.t,err_x_rd/1000,'-r')
  hold on
  plot(t,err_x_ab/1000,'-b')
  xlabel('t, s')
  ylabel('error crd, km')

  subplot(2,1,2)
  plot(KFilter_res_rd.t,err_v_rd,'-r')
  hold on
  plot(t,err_v_ab,'-b')
  xlabel('t, s')
  ylabel('error V, m/s')
  
  %% minimize error
  sigma_ksi = 1;
  X0 = [track.poits(1).true_crd(1,1); 
        track.poits(1).true_vel(1,1); 
        track.poits(1).true_crd(2,1); 
        track.poits(1).true_vel(2,1); 
        track.poits(1).true_crd(3,1); 
        track.poits(1).true_vel(3,1);];

  KFilter_res_rd = RDKalmanFilter3D(track, config, X0, sigma_ksi);
  process_params.T_nak = 30;
  process_params.T_res = 5;
  process_params.abc = [0.5 0.1 0.1];
  a = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
  b = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
  c = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
  [t, X, Xf] = process_track(track, config, process_params);
  X_true = true_params(track,t);
  figure
  for i = 1:11
       process_params.abc(1) = a(i);
       [t, X, Xf] = process_track(track, config, process_params);
       error_crd =  Xf([1 4 7],:) - X_true([1 4 7],:);

       subplot(11,1,i)
       plot(t, error_crd)
         
  end
  figure
  for i = 1:1
       process_params.abc(2) = b(i);
       [t, X, Xf] = process_track(track, config, process_params);
       error_V =  Xf([2 5 8],:) - X_true([2 5 8],:);

       subplot(11,1,i)
       plot(t, error_V)
        
  end
 %{
  [t, X, Xf] = process_track(track, config, process_params);
  X_true = true_params(track,t);
  
  err_x_ab = Xf([1 3 5],:) - X_true([1 3 5],:);
  err_v_ab = Xf([2 4 6],:) - X_true([2 4 6],:);
 %}
  
  %{
  figure
  plot(t,err_x_ab,'-b')
  xlabel('t, c')
  ylabel('error X, км')

  figure
  plot(t,err_v_ab,'-b')
  xlabel('t, c')
  ylabel('error V, м/c')
  %}
    
