function [N,Q,U] = NURBS(x)
    [m,~]=size(x);
    k=3;
%-------�ҳ���������ʵ�����ݵ������----------
    U0=zeros(1,m);
    x0=[x;zeros(1,size(x,2))]-[zeros(1,size(x,2));x];
    x00=x0(2:end-1,:);
    for i=2:m
        U0(i)=U0(i-1)-norm(x00(i-1,:));
    end
    U0=U0/U0(m);
%------------------�����ڵ�����--------------------------
     U=[zeros(1,k),U0,ones(1,k)];
%-------------------������Ƶ�--------------------------------------
     %����A*Q=b     QΪ���Ƶ㣬AΪϵ������bΪ·����
     b=[zeros(1,size(x,2));x;zeros(1,size(x,2))];
     %���Ƕ˵����ݵ�Ϊ���Ƶ㣬�������ڶ˵㴦����Ƶ��������У�
     %������˵���Ƶ�ǰ����Ӧ����ͬ�Ŀ��Ƶ�(�ص�)
     A=zeros(m+2);
     A(1,1)=1;A(1,2)=-1;
     A(2,2)=1;
     A(m+2,m+1)=-1;A(m+2,m+2)=1;
     A(m+1,m+1)=1;
      for i=3:m
         for j=0:2
            A(i,i+j-1)=Bbase(i+j-2,k,U(i+2),U);
         end
      end
     %������Ƶ�
     % Q=A\b;
     Q=inv(A'*A)*A'*b;
%-------------------���߲岹-------------------------
    x=0;y=0;z=0;NUM=0;
     for j=1:(m-1)
           UU=U(j+k):0.0005:U(j+k+1);
          for a=1:length(UU)
               NUM=NUM+1;
               x(NUM)=Q(j,1)*Bbase(j-1,k,UU(a),U)+Q(j+1,1)*Bbase(j,k,UU(a),U)+Q(j+2,1)*Bbase(j+1,k,UU(a),U)+Q(j+3,1)*Bbase(j+2,k,UU(a),U);
               y(NUM)=Q(j,2)*Bbase(j-1,k,UU(a),U)+Q(j+1,2)*Bbase(j,k,UU(a),U)+Q(j+2,2)*Bbase(j+1,k,UU(a),U)+Q(j+3,2)*Bbase(j+2,k,UU(a),U);
               z(NUM)=Q(j,3)*Bbase(j-1,k,UU(a),U)+Q(j+1,3)*Bbase(j,k,UU(a),U)+Q(j+2,3)*Bbase(j+1,k,UU(a),U)+Q(j+3,3)*Bbase(j+2,k,UU(a),U);
          end
     end
 %----------------������ߵ�-----------------------
    N=[x',y',z'];
    
end

