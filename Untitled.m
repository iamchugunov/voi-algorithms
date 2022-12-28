clear;
close all;
a = 1;
c = physconst('LightSpeed');
Tmax = 10;
Tk = 10*10^(-3);
Ti = 0.2*10^(-6);
sizek = Tmax/Tk+1;
sizei = Tk/Ti+1;
w0 = 2*pi*1602*10^6;
wp = 2*pi*2*10^6;
sig_alfa = 10;
Sksi = 2*sig_alfa^2*a*(w0/c)^2;
sig_ksi = Sksi/2*Tk;
sig_dzeta = 0.5;
sig_n = 35.4;
sig_del = 1;
a_del = 0.1;
Shi = 2*sig_del^2*a_del;
sig_hi = (Shi/(2*Tk))^0.5;
x(:,1) = [1 pi/12 100 1]';
x_ocenka(:,1) = [0.5 0 0 0]';
eps_a(1) = x_ocenka(1,1) - x(1,1);
eps_fi(1) = rad2deg(x_ocenka(2,1) - x(2,1));
eps_omega(1) = x_ocenka(3,1) - x(3,1);
Dx = [0.3^2 0 0 0
0 pi^2 0 0
0 0 34^2 0
0 0 0 1];
Dksi = [sig_dzeta^2 0
0 sig_hi^2];
F = [1 0 0 0
0 1 Tk 0
0 0 1 -w0/c*Tk
0 0 0 1-a_del*Tk];
F2 = [0 0 Tk 0]';
G = [Tk 0
0 0
0 0
0 a_del*Tk];
C = [1 0 0 0
0 1 0 0];
D22(1) = rad2deg(sqrt(Dx(2,2)));
t_graph(1) = 0;
V(1) = 100;
y2(1) = V(1) + w0/c*x(4,1);
for k = 2:1:sizek
t_graph(k) = (k-1)*Tk;
hi(1) = randn(1,1) * sig_dzeta;
hi(2) = randn(1,1) * sig_hi;
ksi = randn(1,1) * sig_ksi;
Ud = zeros(2,1);
% Шаг экстраполяции
x(:,k) = F*x(:,k-1)+F2*y2(k-1)+G*hi(:);
V(k) = V(k-1)*(1-a*Tk) + a*Tk*ksi;
y2(k) = V(k) + w0/c*x(4,k);
x_extr = F*x_ocenka(:,k-1)+F2*y2(k);
D_extr = F*Dx*F' + G*Dksi*G';
for i = 1:1:sizei
n = randn(1,1) * sig_n;
y = x(1,k)*cos(wp*((k-1)*Tk+(i-1)*Ti) + x(2,k)) + n;
Ud(1) = Ud(1) + y*cos(wp*((k-1)*Tk+(i-1)*Ti) + x_extr(2));
Ud(2) = Ud(2) + y*sin(wp*((k-1)*Tk+(i-1)*Ti) + x_extr(2));
end
Ud(1) = (Ud(1) - x_extr(1)*sizei/2)/sig_n^2;
Ud(2) = -x_extr(1)*Ud(2)/sig_n^2;
Wk = [sizei/(2*sig_n^2) 0
0 sizei*x_extr(1)^2/(2*sig_n^2)];
% Шаг оценки
Dx = inv(inv(D_extr) + C'*Wk*C);
D11(k) = sqrt(Dx(1,1));
D22(k) = rad2deg(sqrt(Dx(2,2)));
D33(k) = sqrt(Dx(3,3));
x_ocenka(:,k) = x_extr + Dx*C'*Ud;
eps_a(k) = x_ocenka(1,k) - x(1,k);
eps_fi(k) = rad2deg(x_ocenka(2,k) - x(2,k));
eps_omega(k) = x_ocenka(3,k) - x(3,k);
if (k-1)*Tk == 5
x(1,k) = 0.5;
end
end
figure;
plot(t_graph, x(1,:), 'k', t_graph, x_ocenka(1,:));
grid on
title('Амплитуда, оценка амплитуды');
xlabel('Время, с');
ylabel('Амплитуда');
legend('Амплитуда','Оценка амплитуды');
figure;
plot(t_graph, x(2,:), 'k', t_graph, x_ocenka(2,:));
grid on
title('Фаза, оценка фазы');
xlabel('Время, с');
ylabel('Фаза, \circ');
legend('Фаза','Оценка фазы');
figure;
plot(t_graph, x(3,:), 'k', t_graph, x_ocenka(3,:));
grid on
title('Частота, оценка частоты');
xlabel('Время, с');
ylabel('Частота, рад/с');
legend('Частота','Оценка частоты');
figure;
plot(t_graph, eps_fi, 'k', t_graph, 3*D22, '--r', t_graph, -3*D22, '--r');
grid on
title('Ошибка фильтрации фазы');
xlabel('t, с');
ylabel('Ошибка фильтрацция фазы, \circ');
legend('Ошибка фильтрацция фазы','3*СКО','-3*СКО');
ylim([-30 30]);
figure;
plot(t_graph, V(:)*c/w0, t_graph, x(4,:), '-r');
grid on
title('Истинное радиальное ускорение и погрешность измерений от ИНС');
xlabel('Время, с');
ylabel('Радиальное ускорение');
legend('Истинное радиальное ускорение','Погрешность измерений от ИНС');