function [Y] = KLNK( A,B )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m,n]=size(A);
[p,q]=size(B);
for x=1:m
    for y=1:n
        Y((x-1)*p+1:x*p,(y-1)*q+1:y*q)=A(x,y).*B;
    end

end
end

