clear all
clc
[x1,y1]=meshgrid(-3.0:0.1:3.0,-3.0:0.1:3.0);
z1=((1-x1.^2).^2+y1.^2).^(-0.5)+((1+x1.^2).^2+y1.^2).^(-0.5);
figure
mesh(x1,y1,z1);
xlabel('x1');
ylabel('y1');
zlabel('z1');
title('��һС��');% ��һС��

[u2,v2]=meshgrid(-3.0:0.1:3.0,-3.0:0.1:3.0);
x2=2*cos(v2)./(exp(u2)+exp(-u2));
y2=2*sin(v2)./(exp(u2)+exp(-u2));
z2=u2-(exp(u2)-exp(-u2))./(exp(u2)+exp(-u2));
figure
mesh(x2,y2,z2);
xlabel('x2');
ylabel('y2');
zlabel('z2');
title('�ڶ�С��');% �ڶ�С��

[u3,v3]=meshgrid(-3.0:0.1:3.0,-3.0:0.1:3.0);
x3=(4+sin(u3)).*cos(v3);
y3=(4+sin(u3)).*sin(v3);
z3=cos(u3)+v3;
figure()
mesh(x3,y3,z3);
xlabel('x3');
ylabel('y3');
zlabel('z3');
title('����С��');% ����С��
