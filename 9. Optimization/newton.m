function [ x ] = newton( f,df,ddf,x0,TOL )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
w(1)=x0;
w(2)=x0-2*TOL;
a=0.5;%�趨a�ĳ�ʼֵ
while abs(w(2)-w(1))>TOL
    w(1)=x0;
    a=fminbnd(@(a) f(x0+a*df(x0)),0,1);
    x0=x0-a*df(x0)/ddf(x0);
    w(2)=x0;
end
x=x0;
end

