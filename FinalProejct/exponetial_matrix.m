function [ E ] = exponetial_matrix( r )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%calculate the exponetial of a matrix
R=skew_matrix(r);
E=eye(3)+sin(norm(r))/norm(r)*R+(1-cos(norm(r)))/norm(r)^2*R^2;
end

