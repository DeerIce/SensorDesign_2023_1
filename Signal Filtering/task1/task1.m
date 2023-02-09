clear;close all;clc;

[x,Fs]=audioread('test.mp3');
x = x(:,1);
x = x';
N = length(x);%求取抽样点数
t = (0:N-1)/Fs;%显示实际时间
y = fft(x);%对信号进行傅里叶变换
f = Fs/N*(0:round(N/2)-1);%显示实际频点的一半，频域映射，转化为HZ

%滤波处理
h=lowPass;
xlp=filter(h,x);
ylp=fft(xlp);

figure(1);
set(gcf,'color','w');%设置窗口背景颜色为白色，gcf指代当前窗口的句柄

subplot(411);
plot(t,x,'g');
xlabel('t/s');ylabel('Amplitude');
title('低通滤波前的信号波形');
grid;

subplot(412);
plot(t,xlp,'g');
xlabel('t/s');ylabel('Amplitude');
title('低通滤波后的信号波形');

subplot(413);
plot(f,abs(y(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('低通滤波前的信号频谱');
xlim([0 3000]);
grid;

subplot(414);
plot(f,abs(ylp(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('低通滤波后的信号频谱');
xlim([0 3000]);
grid;