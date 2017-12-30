clear all
clc
format long;
f=@(x) x^6+3*x^4-2*x^3+x^2-x-7;
df=@(x) 6*x^5+12*x^3-6*x^2+2*x-1;
ddf=@(x) 30*x^4+36*x^2-12*x+2;
figure;
fplot(f,[0,1]);
xlabel('x');
ylabel('y');
title('f=@(x) x^6+3*x^4-2*x^3+x^2-x-7�ĺ���ͼ��');
grid on;
interval=[0,1];%Ѱ�ҵ�������Ϊ[0,1]
TOL=10^(-5);
h=10^(-5);%���岽��Ϊ10^��-5��
%goldsec�����
x_goldsec=goldsec(f,interval,TOL)
f_goldsec=f(x_goldsec);
%newton�����
x_newton=newton(f,df,ddf,interval(1),TOL)
f_newton=f(x_newton);
%qusi_newton�����
x_qusi_newton=qusi_newton(f,interval(1),h,TOL)
f_qusi_newton=f(x_qusi_newton);
%�Դ��������
[x_fminbnd,f_fminbnd]=fminbnd(f,interval(1),interval(2))
f_goldsec
f_newton
f_qusi_newton
