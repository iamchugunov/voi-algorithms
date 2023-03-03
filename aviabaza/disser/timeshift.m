clear all
T = 0.1;
t_i = 0:T:1000;
sigma = 1e-9;
delta = [0;0];
t(1) = t_i(1) - delta(1);
for i = 2:length(t_i)
    randnum = normrnd(0,sigma);
    t(i) = t(i-1) + (t_i(i) - t_i(i-1))/(1 + delta(2,i-1));
    dt = t(i) - t(i-1);
    F = [1 dt; 0 1];
    G = [0;dt];
    delta(:,i) = F * delta(:,i-1) + G * randnum;
end
% subplot(211)
% plot(t_i-t,'.-')
% hold on
% plot(delta(1,:),'o-')
% hold off
% subplot(212)
% plot(diff(t))
% hold on
% plot(diff(t_i))
% plot((delta(2,:))+T)
% hold off
% std(diff(t))
%%
figure(1)
hold on
plot((t_i-t)*1000,'linewidth',2)
grid minor
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('?_?=10^{-8} сек','?_?=10^{-9}')
xlabel('k')
ylabel('t^{ШВИ}-t^{ШВС}, мс')
figure(2)
hold on
plot((diff(t))*1000,'linewidth',2)
grid minor
set(gca,'FontSize',14)
set(gca,'FontName','Times')
legend('?_?=10^{-8} сек','?_?=10^{-9} сек')
xlabel('k')
ylabel('Период^{ШВС}, мс')