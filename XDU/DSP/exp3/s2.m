n = -16:16;
xn = cos(pi*n/8);
omega = linspace(0,2*pi,1000);
X = xn * exp(-j*n'*omega); % DTFT

figure(1)

subplot(1,2,1)
plot(omega,abs(X),'g')
grid on;
xlim([0 2*pi])
title('幅频特性');
xlabel('\omega');
ylabel('|X(e^{j\omega})|');

subplot(1,2,2)
plot(omega,angle(X),'b')
grid on;
title('相频特性');
xlabel('\omega');
ylabel('arg[X(e^{j\omega})]');
xlim([0 2*pi])

figure(2)

subplot(1,2,1);
plot(omega,real(X),'y')
grid on;
xlim([0 2*pi])
title('实部');
xlabel('\omega');
ylabel('X_R(e^{j\omega})');

subplot(1,2,2);
plot(omega,imag(X),'m')
grid on;
xlim([0 2*pi])
title('虚部');
xlabel('\omega');
ylabel('X_I(e^{j\omega})');