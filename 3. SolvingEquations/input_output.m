clear all
clc
A=input('���������ݶ�[x1,y1,x2,y2......](һ��Ҫ���뷽���ţ�)=')
B=reshape(A,2,[]);
fid=fopen('data.txt','w');
fprintf(fid,'%d %d\n',B);
fclose(fid);