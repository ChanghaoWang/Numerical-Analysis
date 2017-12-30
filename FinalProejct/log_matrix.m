function [ log_R ] = log_matrix( R )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
theta=acos(trace(R)-1);
[V,D]=eig(R);
for i=1:3
    if D(i,i)==1
        break;
    end
end
v=V(:,i);
if trace(R)~=1
    log_R=theta/(2*sin(theta))*(R-R.');
else
    log_R=[-pi*skew_matrix(v),pi*skew_matrix(v)];
end

end

