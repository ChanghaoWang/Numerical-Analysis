function [P,P0 ] = lag_my( X,Y,x0 )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
n=length(X);
syms x 
P(x)=0*x;
F(x)=0*x;
for  k=1:n
    l(x)=0*x+1;
    for j=1:n
        if j==k
            continue;
        else
            l(x)=l(x)*(x-X(j))/(X(k)-X(j));
        end
    end
    P(x)=P(x)+Y(k)*l(x);
end
P0=P(x0);
end