clear;close all;clc;

[x,Fs]=audioread('test.mp3');
x = x(:,1);
x = x';
N = length(x);%��ȡ��������
t = (0:N-1)/Fs;%��ʾʵ��ʱ��
y = fft(x);%���źŽ��и���Ҷ�任
f = Fs/N*(0:round(N/2)-1);%��ʾʵ��Ƶ���һ�룬Ƶ��ӳ�䣬ת��ΪHZ

%�˲�����
h=lowPass;
xlp=filter(h,x);
ylp=fft(xlp);

figure(1);
set(gcf,'color','w');%���ô��ڱ�����ɫΪ��ɫ��gcfָ����ǰ���ڵľ��

subplot(411);
plot(t,x,'g');
xlabel('t/s');ylabel('Amplitude');
title('��ͨ�˲�ǰ���źŲ���');
grid;

subplot(412);
plot(t,xlp,'g');
xlabel('t/s');ylabel('Amplitude');
title('��ͨ�˲�����źŲ���');

subplot(413);
plot(f,abs(y(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('��ͨ�˲�ǰ���ź�Ƶ��');
xlim([0 3000]);
grid;

subplot(414);
plot(f,abs(ylp(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('��ͨ�˲�����ź�Ƶ��');
xlim([0 3000]);
grid;