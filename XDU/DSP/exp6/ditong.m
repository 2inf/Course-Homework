% Low-pass filter
Wp=0.2*pi; Ws=pi/2; Rs=40; B=Ws-Wp;
beta=0.5842*(Rs-21)^0.4+0.07886*(Rs-21)
N0=ceil((Rs-7.95)/2.285/B)+1;
N=N0+mod(N0+1,2)
Wc=(Wp+Ws)/2/pi

h=fir1(N-1,Wc,kaiser(N,beta));

figure(1)
n=0:1:N-1;
stem(n, h, 'filled', 'MarkerSize', 3);
xlabel('n'); ylabel('h(n)');
title('Unit impulse response');

[H,W] = freqz(h,1,512);
figure(2)
subplot(1,2,1);
plot(W/pi,20*log10(abs(H)),'g'); grid on;
xlabel('\omega/\pi'); ylabel('|H(e^j^\omega)|/dB');
title('Magnitude Response');
subplot(1,2,2);
plot(W/pi,angle(H)/pi,'b');grid on;
xlabel('\omega/\pi'); ylabel('\phi(\omega)/\pi');
title('Phase Response');