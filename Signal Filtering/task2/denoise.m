clear;close all;clc;

[x,Fs]=audioread('test.mp3');
x = x(:,1);
x = x';
N = length(x);
t = (0:N-1)/Fs;%��ʾʵ��ʱ��
y = fft(x);%���źŽ��и���Ҷ�任
f = Fs/N*(0:round(N/2)-1);%��ʾʵ��Ƶ���һ�룬Ƶ��ӳ�䣬ת��ΪHZ

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
title('ԭ�źŲ���');
grid;

subplot(412);
plot(t,xx,'g');
xlabel('tt/s');ylabel('Amplitude');
title('���������źŲ���');
grid;

subplot(413);
plot(f,abs(y(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('ԭ�ź�Ƶ��');
xlim([0 1000]);
grid;

subplot(414);
plot(f,abs(yy(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('���������ź�Ƶ��');
xlim([1 1000]);
grid;

%�˲�����
h=noiseFilter;
xxlp=filter(h,xx);
yylp=fft(xxlp);

figure(2);
set(gcf,'color','w');

subplot(211);
plot(f,abs(yy(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('���������ź�Ƶ��');
xlim([0 1000]);
grid;

subplot(212);
plot(f,abs(yylp(1:round(N/2))));
xlabel('f/Hz');ylabel('Amplitude');
title('�������ź�Ƶ��');
xlim([0 1000]);
grid;

% sound(xx,Fs);%���Ž���ǰ����Ƶ
% sound(xxlp,Fs);%���Ž�������Ƶ