b = [1, 2];
a = [1, -1]; %��ַ��̵�ϵ��
x = [4, 3, 2, 1]'; %��������

[h, t] = impz(b, a, 10); %��λ������Ӧ

%����Ϊ8
L1 = 8;
X = fft(x, L1);
H = fft(h, L1);
Y = X.*H; %Ƶ�����
yl1=ifft(Y,L1);

figure(1);
stem(yl1, 'b', 'filled', 'MarkerSize', 3); grid on;
xlabel('n');
ylabel('yl_1(n)');
title('L=8�Ŀ������Ծ��')

%����Ϊ16
L2 = 16;
X = fft(x, L2);
H = fft(h, L2);
Y = X.*H; %Ƶ�����
yl2=ifft(Y,L2);

figure(2);
stem(yl2, 'b', 'filled', 'MarkerSize', 3); grid on;
xlabel('n');
ylabel('yl_2(n)');
title('L=16ʱ�Ŀ������Ծ��')

%ʱ�����Ľ��
yc = conv(x, h);

figure(3);
stem(yc, 'r', 'filled', 'MarkerSize', 3); grid on;
xlabel('n');
ylabel('yc(n)');
title('ѭ�����')