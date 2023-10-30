b=[1];
a=[1 -0.6];
[h,n]=impz(b,a); % 单位冲激响应
[H,omega]=freqz(b,a,'whole');
H1=abs(H); % 幅频特性
H2=angle(H); % 相频特性

figure;
stem(n,h,'r','filled','MarkerSize',4)
grid on;
title('单位脉冲响应');
xlabel('n');ylabel('h(n)');

figure;
zplane(b,a) % 零极点分布
grid on;
title('零极点分布')
xlabel('Re[z]');ylabel('jIm[z]');

figure;
subplot(1,2,1);
plot(omega/pi,H1,'g')
grid on;
ylabel('|H(e^{j\omega})|')
xlabel('\omega/\pi')
title('幅频特性')

subplot(1,2,2);
plot(omega/pi,H2/pi,'b');
grid on;
ylabel('\phi(\omega)/\pi')
xlabel('\omega/\pi')
title('相频特性');