clear all
clc
format long
x0=[0.1,0.1,0.1].';
x=[0,0,0].';
while abs(x0(1)-x(1)>0.5*10^(-6)) | abs(x0(2)-x(2)>0.5*10^(-6)) | abs(x0(2)-x(2)>0.5*10^(-6))
    x=x0;
    x0(1)=(1/3)*cos(x(2)*x(3))+1/6;
    x0(2)=(1/9)*(x(1)^2+sin(x(3))+1.06)^0.5-0.1;
    x0(3)=-(1/20)*exp(-x(1)*x(2))-(10*pi-3)/60;
  
end
x0

