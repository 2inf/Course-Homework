% ��ɢ�ź�
% ������ɢ���� f(k) = 2(0.8).^k 
c = 2;d = 0.8;k = 0:20;
f = c*d.^k;
figure
stem(k, f,'filled','MarkerSize',3)
xlabel('n');ylabel('f(n)');title('��������');
grid on;

% �����ַ��� y(n)+y(n-1)+y(n-2) = f(n)+2f(n-1)+3f(n-2), ��λ������Ӧ
a = [1,1,1];
b = [1 2 3];
h = impz(b,a,k); % ��λ������Ӧ
z = [1,1]; % ��ʼ״̬(y(-1)=1, y(-2)=1)
yzi = filter(b,a,0*f,filtic(b,a,z)); %��������Ӧ
yzs = filter(b,a,f); % ��״̬��Ӧ
y = yzi + yzs; % ȫ��Ӧ

figure
subplot(2,2,1);
stem(k,h,'filled','MarkerSize',3);
xlabel('n');ylabel('h(n)');title('��λ������Ӧ');

subplot(2,2,2);
stem(k,yzi,'filled','MarkerSize',3);
xlabel('n');ylabel('y_{zi}(n)');title('��������Ӧ');

subplot(2,2,3);
stem(k,yzs,'filled','MarkerSize',3);
xlabel('n');ylabel('y_{zs}(n)');title('��״̬��Ӧ');

subplot(2,2,4);
stem(k,y,'filled','MarkerSize',3);
xlabel('n');ylabel('y(n)');title('ȫ��Ӧ');

yc = conv(f, h); % �������״̬��Ӧ
figure
stem(k,yc(1:21),'filled','MarkerSize',3);
xlabel('n');ylabel('y_{c}(n)');title('��״̬��Ӧ');
grid on;