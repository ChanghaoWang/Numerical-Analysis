function [ x,y ] = steepest_descend( f,dfx,dfy,x0,y0,a,TOL )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
d=[dfx(x0,y0);dfy(x0,y0)];
while norm(d)>TOL
        x0=x0+a*d(1);
        y0=y0+a*d(2);
        a=
        d=[dfx(x0,y0);dfy(x0,y0)];
end
x=x0;
y=y0;
end

