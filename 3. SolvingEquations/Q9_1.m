clear all
clc
format long
syms x
y=tan(pi-x);
z=x;
p1=ezplot(y,[-0.5*pi,1.5*pi]);
hold on
p2=ezplot(z,[-0.5*pi,1.5*pi]);
set(p2,'Color','r','linewidth',2.0,'linestyle','--')
xlabel('x��');
ylabel('y����z');
title('y=x;y=tan(pi-x)������');
legend('y=tan(pi-x)','y=x');