function [ x ] = Sum( A,B)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
f=@(A,B) KLNK(A,B);
Y=f(A,B)-f(B,A);
[m,n]=size(Y);
y(1)=0;
for a=2:m*n+1
    y(a)=y(a-1)+Y(a-1);
end
x=y(m*n);


end

