function [ X ] = Normal_Equation( A,b )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m1,n1]=size(A);
[m2,n2]=size(b);
if n2~=1
    disp('error');
else
    X=inv(A.'*A)*A.'*b;
end
end