clear all
clc
syms x
a=0;
b=pi;
m=10;%���㺯��10��չ��
T=b-a;
w=2*pi/T;
a0=(2/T*int(x^2,x,0,T));
f=a0/2;
for n=1:m
    a(n)=2/T*int(x^2*cos(n*w*x),x,0,T);
    b(n)=2/T*int(x^2*sin(n*w*x),x,0,T);
    f=f+a(n)*cos(n*w*x)+b(n)*sin(n*w*x);
end
a=[a0,a];
disp('an��ϵ��Ϊ��');
disp(a);
disp('bn��ϵ��Ϊ��');
disp(b);
disp('x^2��ǰ10��չ��ʽΪ��');
pretty(simplify(f))