clear all
clc
format long
syms x
f(x)=tan(pi-x)-x;
A=['solve�����Ĵ�Ϊ��'];
disp(A);
solve(f(x)==0)
a=2;
B=['fzero,x=2�Ĵ�Ϊ��'];
disp(B);
fzero(f,a)