function [ w ] = w_matrix( r,dr )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%calculate the angular velocity matrix
A=eye(3)-(1-cos(norm(r)))/norm(r)^2*skew_matrix(r)+(norm(r)-sin(norm(r)))/norm(r)^3*skew_matrix(r)^3;
w=A*dr;
end

