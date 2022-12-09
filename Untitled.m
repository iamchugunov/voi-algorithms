clc
close all
% Дано:
c = 3e8;
a = 1; %ширина спектра флуктцаций ускорения
T = 10e-3; %темп фильтрации
Td = 0.2e-6; %темп работы АЦП
N = T/Td; %количество отсчетов
omega0 = 2*pi*1602e6; %несущая частота
omega_p = 2*pi*2e3; %промежуточная частота
sigma_a = 10;
S_ksi = 2*sigma_a^2*a*(omega0/c)*(omega0/c);
D_ksi = S_ksi/(2*T);
a0 = 1;
D_dzeta = 0.5;
q = 10^(0.1*30); %сигнал-шум
sigma_n = a0/(2*sqrt(q*Td));
D_n = sigma_n^2;
t_start = 0;
t_finish = 2; %2 сек
t = t_start:T:t_finish;
% Рассчитанные коэффициенты
F = [1 0 0 0; 0 1 T 0; 0 0 1 T; 0 0 0 1-a*T];
G = [T 0; 0 0; 0 0; 0 a*T];
DD_ksi = [D_dzeta 0; 0 D_ksi];
c = [1 0 0 0; 0 1 0 0];
% Начальные условия
D = [0.3^2 0 0 0; 0 pi^2 0 0; 0 0 34^2 0; 0 0 0 340*340];
x = [1; pi/12; 100; 100];
x_k = [0.5; 0; 0; 0];
% Задание начальных приближений
A(1) = x(1);
phi(1) = x(2);
OMEGA(1) = x(3);
A_k(1) = 0;
phi_k(1) = 0;
OMEGA_k(1) = 0;
D11(1) = D(1,1);
D22(1) = D(2,2);
D33(1) = D(3,3);
for i = 1:length(t)
A(i) = x(1);
phi(i) = x(2);
OMEGA(i) = x(3);
x = F*x+G*randn(1,1)*sqrt(DD_ksi); % фильтруемый процесс
x_k = F*x_k; % шаг экстраполяции
D = F*D*F' + G*DD_ksi*G';
phi_k(i) = x_k(2);
for ii = 1:N % задание ступенчатой амплитуды
jj = (i-2)*N+ii;
if jj*Td <= 1
A = 1;
else
A = 0.5;
end
y = A*cos(omega_p*jj*Td+phi(i))+randn(1,1)*sigma_n; % входное воздействие
u_a(ii) = y*cos(omega_p*jj*Td+phi_k(i)); % частная производная вх.возд по амплитуде
u_phi(ii) = y*sin(omega_p*jj*Td+phi_k(i)); % частная производная вх.возд по частоте
end
u_da = sum(u_a)*(1/D_n) - (x_k(1)*N)/(2*D_n); % уравнение фильтрации амплитуды
u_dphi = -sum(u_phi)*(x_k(1)/D_n); % уравнение фильтрации частоты
u_d = [u_da; u_dphi]; % матрица фильтрации
W = N/(2*D_n)*[1 0; 0 x_k(1)*x_k(1)]; % матрица весовых наблюдений
D = inv(inv(D) + c'*W*c);
x_k = x_k + D*c'*u_d; % шаг оценивания
D11(i) = D(1,1);
D22(i) = D(2,2);
D33(i) = D(3,3);
if i*T <= 1
Ak = 1;
else
Ak = 0.5;
end
A_k(i) = x_k(1);
d_A(i) = A_k(i) - Ak;
OMEGA_k(i) = x_k(3);
end
d_phi = phi_k - phi;
d_OMEGA = OMEGA_k - OMEGA;
% Построение графиков
figure(1)
hold on;
grid on;
plot(t, d_phi*180/pi, t, 3*sqrt(D22)*180/pi, '-r', t, -3*sqrt(D22)*180/pi, '-r');
xlabel('Время, с');
ylabel('Мгновенные ошибки фильтрации фазы, град');
figure(2)
hold on;
grid on;
plot(t, d_A, t, 3*sqrt(D11), '-r', t, -3*sqrt(D11), '-r');
xlabel('Время, с');
ylabel('Мгновенные ошибки фильтрации амплитуды, ед');
figure(3)
hold on;
grid on;
plot(t, d_OMEGA, t, 3*sqrt(D33), '-r', t, -3*sqrt(D33), '-r');
xlabel('Время, с');
ylabel('Мгновенные ошибки фильтрации частоты, рад/с');