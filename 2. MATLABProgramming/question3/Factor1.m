function [ y ] = Factor1( x )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if x<=1
    y=1;
else 
    y=Factor1(x-1)*x;
end

end

