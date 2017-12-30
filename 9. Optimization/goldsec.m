function [ x ] = goldsec( f,interval,TOL )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
g=(sqrt(5)-1)/2;
a=interval(1);
b=interval(2);
x1=a+(1-g)*(b-a);
x2=a+g*(b-a);
while (b-a)>TOL
    if f(x1)>f(x2)
        a=x1;
        x1=x2;
        x2=a+g*(b-a);
    else
        b=x2;
        x2=x1;
        x1=a+(1-g)*(b-a);
    end
end
x=(b+a)/2;
end

