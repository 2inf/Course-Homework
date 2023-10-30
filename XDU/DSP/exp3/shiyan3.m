b=[1];
a=[1 -0.6];
[h,n]=impz(b,a); % ��λ�弤��Ӧ
[H,omega]=freqz(b,a,'whole');
H1=abs(H); % ��Ƶ����
H2=angle(H); % ��Ƶ����

figure;
stem(n,h,'r','filled','MarkerSize',4)
grid on;
title('��λ������Ӧ');
xlabel('n');ylabel('h(n)');

figure;
zplane(b,a) % �㼫��ֲ�
grid on;
title('�㼫��ֲ�')
xlabel('Re[z]');ylabel('jIm[z]');

figure;
subplot(1,2,1);
plot(omega/pi,H1,'g')
grid on;
ylabel('|H(e^{j\omega})|')
xlabel('\omega/\pi')
title('��Ƶ����')

subplot(1,2,2);
plot(omega/pi,H2/pi,'b');
grid on;
ylabel('\phi(\omega)/\pi')
xlabel('\omega/\pi')
title('��Ƶ����');