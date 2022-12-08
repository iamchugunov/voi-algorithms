function [] = show_mod_V(traj_params, track)
time_interval = traj_params.time_interval;
t = time_interval(1):1:time_interval(end);

mas = [];
for i = 1 : length(t)
    Vmod = [track.vel(1,i) track.vel(2,i) track.vel(3,i)];
    %Vmod = sqrt( track.vel(1,i)^2 + track.vel(2,i)^2 + track.vel(3,i)^2 );
    mas(i) = norm(Vmod);
end
figure
plot(1:length(t),mas, 'r-');
grid on  
hold on
xlabel('t, c')
ylabel('V, м/c')
  