clear;close all;clc;

[x,Fs]=audioread('test.mp3');
x = x(:,1);
x = x';
N = length(x);
t = (0:N-1)/Fs;%显示实际时间
y = fft(x);%对信号进行傅里叶变换
f = Fs/N*(0:round(N/2)-1);%显示实际频点的一半，频域映射，转化为HZ

noise_f=100*rand(1,10)+900*ones(1,10);
xx=0;
for k=1:length(noise_f)
    xx=0.02*sin(2*pi*noise_f(k)*t)+xx;
end
xx=xx+x;
yy = fft(xx);

figure(1);
set(gcf,'color','w');

subplot(411);
plot(t,x,'g');
xlabel('t/s');ylabel('Amplitude');
title('原信号波形');
grid;

subplot(412);
plot(t,xx,'g');
xlabel('tt/s');ylabel('Amplitude');
title('带噪声的信号波形');
grid;

subplot(413);
plot(f,abs(y(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('原信号频谱');
xlim([0 1000]);
grid;

subplot(414);
plot(f,abs(yy(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('带噪声的信号频谱');
xlim([1 1000]);
grid;

%滤波处理
h=noiseFilter;
xxlp=filter(h,xx);
yylp=fft(xxlp);

figure(2);
set(gcf,'color','w');

subplot(211);
plot(f,abs(yy(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('带噪声的信号频谱');
xlim([0 1000]);
grid;

subplot(212);
plot(f,abs(yylp(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('降噪后的信号频谱');
xlim([0 1000]);
grid;

% sound(xx,Fs);%播放降噪前的音频
% sound(xxlp,Fs);%播放降噪后的音频