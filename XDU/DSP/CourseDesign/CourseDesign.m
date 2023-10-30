% 问题 1
N = 2000; L = 2; k = 0:N-1;
dt = L / N; t = k * dt; f = k / L;

f1 = 10; f2 = 6; f3 = 36; f4 = 25;
sa1 = cos(2*pi*f1*t)+cos(2*pi*f2*t);
sa2 = 10*cos(2*pi*f3*t)+10*cos(2*pi*f4*t);
xa = sa1 + sa2;
F1 = fft(sa1,N);
F2 = fft(sa2,N);
F3 = fft(xa,N);

figure(1);
subplot(1,2,1)
plot(t,sa1,'b','LineWidth',0.8); grid on;
xlabel('t/s'); ylabel('sa_1(t)');
xlim([0 1]); title('有用信号');

subplot(1,2,2)
plot(f,0.5*abs(F1)/max(abs(F1)),'g','LineWidth',0.8); grid on;
xlabel('f/Hz'); ylabel('F(j2\pif)');
axis([0 40 0 1]); title('频谱图');

figure(2);
subplot(1,2,1)
plot(t,sa2,'b','LineWidth',0.8); grid on;
xlabel('t/s'); ylabel('sa_2(t)');
xlim([0 1]); title('干扰信号');

subplot(1,2,2)
plot(f,5*abs(F2)/max(abs(F2)),'g','LineWidth',0.8); grid on;
xlabel('f/Hz'); ylabel('F(j2\pif)');
axis([0 40 0 10]); title('频谱图');

figure(3);
subplot(1,2,1)
plot(t,xa,'b','LineWidth',0.8); grid on;
xlabel('t/s'); ylabel('xa(t)');
xlim([0 1]); title('合成信号');

subplot(1,2,2)
plot(f,5*abs(F3)/max(abs(F3)),'g','LineWidth',0.8); grid on;
xlabel('f/Hz'); ylabel('F(j2\pif)');
axis([0 40 0 10]); title('频谱图');

% 问题 2
Fs = 100; Ts = 1 / Fs; n = 0:199;
tn = n * Ts;
sn1 = cos(2*pi*f1*tn)+cos(2*pi*f2*tn);
sn2 = 10*cos(2*pi*f3*tn)+10*cos(2*pi*f4*tn);
xn = sn1 + sn2;
Fn1 = fft(sn1);
Fn2 = fft(sn2);
Fn3 = fft(xn);

figure(4);
subplot(1,2,1)
stem(n,sn1,'r','filled','LineWidth',0.6,'MarkerSize',3); grid on;
xlabel('n'); ylabel('s_1(n)');
xlim([0 100]); title('离散有用信号');

subplot(1,2,2)
stem(abs(Fn1),'m','filled','LineWidth',0.6,'MarkerSize',3); grid on;
xlabel('k'); ylabel('|S_1(k)|');
title('FFT Amplitude')

figure(5);
subplot(1,2,1)
stem(n,sn2,'r','filled','LineWidth',0.6,'MarkerSize',3); grid on;
xlabel('n'); ylabel('s_2(n)');
xlim([0 100]); title('离散干扰信号');

subplot(1,2,2)
stem(abs(Fn2),'m','filled','LineWidth',0.6,'MarkerSize',3); grid on;
xlabel('k'); ylabel('|S_2(k)|');
title('FFT Amplitude')

figure(6);
subplot(1,2,1)
stem(n,xn,'r','filled','LineWidth',0.6,'MarkerSize',3); grid on;
xlabel('n'); ylabel('x(n)');
xlim([0 100]); title('离散合成信号');

subplot(1,2,2)
stem(abs(Fn3),'m','filled','LineWidth',0.6,'MarkerSize',3); grid on;
xlabel('k'); ylabel('|X(k)|');
title('FFT Amplitude')

% 问题 3
fp=12; fs=20;
Wp=2*fp/Fs; Ws=2*fs/Fs; Rp=1; Rs=40;
[N,Wc] = buttord(Wp,Ws,Rp,Rs)
[B,A] = butter(N,Wc)
[H,w] = freqz(B,A,1000);

figure(7);
subplot(1,2,1);
plot(w/pi, 20*log10(abs(H)),'g','LineWidth',0.8); grid on;
xlabel('\omega/\pi'); ylabel('|H(e^j^\omega)|/dB');
title('Magnitude Response');

subplot(1,2,2);
plot(w/pi, angle(H)/pi,'b','LineWidth',0.8); grid on;
xlabel('\omega/\pi'); ylabel('\phi(\omega)/\pi');
title('Phase Response');

% 问题 5
yn = filter(B,A,xn);
Yk = fft(yn);

n = 0:length(yn)-1;
figure(8);
subplot(1,2,1)
stem(n,yn,'r','filled','LineWidth',0.6,'MarkerSize',3); grid on;
% plot(n,yn,'b','LineWidth',1); hold on; grid on;
xlabel('n'); ylabel('y(n)');
xlim([0 100]); title('滤波输出 y(n)');

subplot(1,2,2)
stem(n,abs(Yk),'m','filled','LineWidth',0.6,'MarkerSize',3); grid on;
xlabel('k'); ylabel('|Y(k)|');
title('FFT Amplitude')