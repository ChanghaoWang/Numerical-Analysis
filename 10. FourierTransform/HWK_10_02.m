clear all
clc
t=0:1/128:2;
f=(0:256)*128/256;
x=5+7*cos(30*pi*t-pi/6)+3*sin(80*pi*t-pi/2);
noise=normpdf(t,0,1);
x1=x+noise;
Y=abs(fft(x1));
figure;
e1=plot(t,x1,'Color','g','LineWidth',2.0);
title('���������ź�');
grid on;
figure;
e2=plot(f,Y,'r');
grid on;
title('�����ź�Ƶ��');
Z=ifft(Y);
figure;
e3=plot(t,Z);
grid on;
title('�ָ��õ����ź�');