clear all
clc
syms x
f(x)=tan(pi-x)-x;
a1=1.5;
b1=3;
while (b1-a1)>10^(-6)
    c1=(a1+b1)/2;
    if f(c1)==0
        disp(c1);
        break;
    elseif f(a1)*f(c1)>0
        b1=c1;
    else
        a1=c1;
    end
end
C=['�ö��ַ�����[1.5,3]�Ĵ�Ϊ��',num2str(c1)];
disp(C);

a2=1.5;
b2=2;
while b2-a2>10^(-6)
    c2=(a2+b2)/2;
    if f(c2)==0
        disp(c2);
        break;
    end
    if f(c2)*f(a2)>0
        b2=c2;
    else
        a2=c2;
    end
end
E=['�ö��ַ�����[1.5,2]�Ĵ�Ϊ��',num2str(c2)];
disp(E);
