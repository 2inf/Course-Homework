% 离散信号
% 生成离散序列 f(k) = 2(0.8).^k 
c = 2;d = 0.8;k = 0:20;
f = c*d.^k;
figure
stem(k, f,'filled','MarkerSize',3)
xlabel('n');ylabel('f(n)');title('输入序列');
grid on;

% 假设差分方程 y(n)+y(n-1)+y(n-2) = f(n)+2f(n-1)+3f(n-2), 求单位脉冲响应
a = [1,1,1];
b = [1 2 3];
h = impz(b,a,k); % 单位脉冲响应
z = [1,1]; % 初始状态(y(-1)=1, y(-2)=1)
yzi = filter(b,a,0*f,filtic(b,a,z)); %零输入响应
yzs = filter(b,a,f); % 零状态响应
y = yzi + yzs; % 全响应

figure
subplot(2,2,1);
stem(k,h,'filled','MarkerSize',3);
xlabel('n');ylabel('h(n)');title('单位脉冲响应');

subplot(2,2,2);
stem(k,yzi,'filled','MarkerSize',3);
xlabel('n');ylabel('y_{zi}(n)');title('零输入响应');

subplot(2,2,3);
stem(k,yzs,'filled','MarkerSize',3);
xlabel('n');ylabel('y_{zs}(n)');title('零状态响应');

subplot(2,2,4);
stem(k,y,'filled','MarkerSize',3);
xlabel('n');ylabel('y(n)');title('全响应');

yc = conv(f, h); % 卷积求零状态响应
figure
stem(k,yc(1:21),'filled','MarkerSize',3);
xlabel('n');ylabel('y_{c}(n)');title('零状态响应');
grid on;