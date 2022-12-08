close all
clear all
T = 50e-6;
s_ksi = 1e-6; % forming noise
shift_v = 1e-5; % parameter for mode 2
shift_const = 1e-7; % parameter for mode 3
shift = 0; % shift in begining
drift(1) = 0; % drift in beginning
drift_t(1) = 0;
T_m(1) = 0; % first transmition time in tag timescale
T_s(1) = T_m(1) + shift(1); % first transmition time in system timescale
for i = 2:10000
    % WE CAN CHOOSE MODEL OF DRIFT
    % 1. mark 1
    drift(i) = drift(i-1) + T * normrnd(0, s_ksi);
    % 1. mark 2
%     drift(i) = drift(i-1) + T * drift_t(i-1);
%     drift_t(i) = drift_t(i-1) + T * normrnd(0, s_ksi);
    % 3. linear
%     drift(i) = drift(i-1) + T * shift_v;
    % 4. const
%     drift(i) = shift_const;
    % 5. WGN
%     drift(i) = normrnd(0, s_ksi);
    
    T_m(i) = T_m(i-1) + T;
    T_s(i) = T_s(i-1) + (1 - drift(i-1))*T;
end
figure
subplot(221)
plot(diff(T_s)*10e6)
hold on
plot(diff(T_m)*10e6)
title('Period, us')
legend('True (in system)','Measured by tag')
subplot(222)
plot(T_s)
hold on
plot(T_m)
legend('True tag timescale measured by system','Tag timescale measured by itself')
title('TimeScale')
subplot(223)
plot(T_s - T_m)
title('difference')
subplot(224)
plot(drift)
title('drift')
