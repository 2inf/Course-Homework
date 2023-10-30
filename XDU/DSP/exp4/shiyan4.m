b = [1, 2];
a = [1, -1]; %差分方程的系数
x = [4, 3, 2, 1]'; %输入序列

[h, t] = impz(b, a, 10); %单位脉冲响应

%长度为8
L1 = 8;
X = fft(x, L1);
H = fft(h, L1);
Y = X.*H; %频域相乘
yl1=ifft(Y,L1);

figure(1);
stem(yl1, 'b', 'filled', 'MarkerSize', 3); grid on;
xlabel('n');
ylabel('yl_1(n)');
title('L=8的快速线性卷积')

%长度为16
L2 = 16;
X = fft(x, L2);
H = fft(h, L2);
Y = X.*H; %频域相乘
yl2=ifft(Y,L2);

figure(2);
stem(yl2, 'b', 'filled', 'MarkerSize', 3); grid on;
xlabel('n');
ylabel('yl_2(n)');
title('L=16时的快速线性卷积')

%时域卷积的结果
yc = conv(x, h);

figure(3);
stem(yc, 'r', 'filled', 'MarkerSize', 3); grid on;
xlabel('n');
ylabel('yc(n)');
title('循环卷积')