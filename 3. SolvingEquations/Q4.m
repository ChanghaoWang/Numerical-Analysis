function [ S ] = Q4( k,x )
k=input('����������k=')
x=input('������x=')
S=0; 
while k<0
    k=input('��������������k=')
    x=input('����������x=')
end
for i=0:k
    S=S+x.^i./prod(1:i).*exp(-x)
end
end

