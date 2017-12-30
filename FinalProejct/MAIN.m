%---------MATLAB����ҵ��������С�飩-----------------------
%ʹ��˵�����������б������ڴ�Nurbs_program���м���
%---------��ȡtxt�����·����-------------------
      x=load('projectdata.txt');
%       x=2*x;
%-------��������·���㷴����Ƶ㣬�������߽�����ֵ������3��NURBS����------
     [N,Q,U]=NURBS(x);%NΪ���ߵ㣬QΪ���Ƶ㣬UΪ�ڵ�����
     t=1:22;
     t=t.';
     x1=[t,x];
    
%-------------------����·����----------------------------
    figure;
    plot3(x(:,1),x(:,2),x(:,3),'ob');
     grid on;
     hold on;
%------------------�������ƶ����-----------------------
%      plot3(Q(:,1),Q(:,2),Q(:,3),'r');
%      hold on;
%----------------����NURBS����-------------------------
     plot3(N(:,1),N(:,2),N(:,3),'g');
     %axis([-1.5 1.5 -1.5 1.5 0.2 1.4]);
     title('����·�����µ�NURBS����','fontsize',20);
     legend('·����','NURBS����');
     xlabel('x');
     ylabel('y');
     zlabel('z');
%----------------���ݽڵ�������------------------------
     %������һ�׵�
     n=1000;
     u=linspace(0.001,0.9999,n);
     Cu=zeros(n,3);
     for i=1:n
         for j=0:size(Q,1)-1
          Cu(i,:)=Cu(i,:)+DiffNB(u(i),U,3,1,j)*Q(j+1,:);
         end;
     end
      %�����߶��׵�
      Cuu=zeros(n,3);
      for i=1:n
          for j=0:size(Q,1)-1
               Cuu(i,:)=Cuu(i,:)+DiffNB(u(i),U,3,2,j)*Q(j+1,:);
          end
      end
      %���������׵�
      Cuuu=zeros(n,3);
      for i=1:n
          for j=0:size(Q,1)-1
               Cuuu(i,:)=Cuuu(i,:)+DiffNB(u(i),U,3,3,j)*Q(j+1,:);
          end
      end
      %��һ�׵�����ģ
      kappa=zeros(n,1);
      for i=1:n
          kappa(i)=norm(Cu(i,:));
      end
%------------------��Լ�������ٶȡ����ٶȹ滮-------------------
     %�ٶ����ֵ
     Vmax=1;
     %׷��������ֵ
     e_max = 0.02;
    %��ֵ�Ĳ���
    Ts = 0.002;
    %���ٶ����ֵ
    Amax=2;
    %������
    lb=zeros(n,1);
    ub=zeros(n,1);
    rho = zeros(n,1);
    for i =2:n-1 % ��ֹ���ʰ뾶���Բ����㣬��Ϊ��ֹ���ٶ�Ϊ0������Ϊ0
        rho(i) = norm(Cu(i,:))^3/norm(cross(Cu(i,:),Cuu(i,:)));
        ub(i) = min(Vmax^2, 8*rho(i)*e_max/(Ts^2));
    end
    %Ŀ�꺯��
    f=-1*ones(n,1);
    %��ʽԼ��(��β�ٶ�Ϊ0)
    Aeq=[1,zeros(1,n-1);zeros(1,n-1),1];
    beq=[0;0];
    %����ʽԼ��(���ٶ�Լ��)
    Ax=zeros(n-2,n);
    Ay=zeros(n-2,n);
    Az=zeros(n-2,n);
    for i=1:n-2
        Ax(i,i)=-1*Cu(i+1,1)/(2*(u(i+2)-u(i))*(kappa(i))^2);
        Ax(i,i+1)=Cuu(i+1,1)/((kappa(i+1))^2);
        Ax(i,i+2)=Cu(i+1,1)/(2*(u(i+2)-u(i))*(kappa(i+2))^2);
    end
    for i=1:n-2
        Ay(i,i)=-Cu(i+1,2)/(2*(u(i+2)-u(i))*(kappa(i))^2);
        Ay(i,i+1)=Cuu(i+1,2)/(kappa(i+1)^2);
        Ay(i,i+2)=Cu(i+1,2)/(2*(u(i+2)-u(i))*(kappa(i+2))^2);
    end
    for i=1:n-2
        Az(i,i)=-Cu(i+1,3)/(2*(u(i+2)-u(i))*(kappa(i))^2);
        Az(i,i+1)=Cuu(i+1,3)/((kappa(i+1))^2);
        Az(i,i+2)=Cu(i+1,3)/(2*(u(i+2)-u(i))*(kappa(i+2))^2);
    end
    A=[Ax;Ay;Az;-Ax;-Ay;-Az];
    bx=Amax*ones(n-2,1);
    by=Amax*ones(n-2,1);
    bz=Amax*ones(n-2,1);
    b=[bx;by;bz;bx;by;bz];
    %�򻯺�����Թ滮�������
    V2=linprog(f,A,b,Aeq,beq,lb,ub);
    %��Ծ��Լ���ٶ�����
%     figure
%     plot(u,sqrt(V2));
%     axis([0 1 -1 3])
%     grid on;
    %��Ծ��Լ�����ٶ�����
    A_X=Ax*V2;
    A_Y=Ay*V2;
    A_Z=Az*V2;
%     figure
%     plot(u(2:n-1),A_X,'g',u(2:n-1),A_Y,'b',u(2:n-1),A_Z,'r');
%     grid on;
    %��Ծ��Լ��Ծ������
    q=V2./(kappa.^2);
    du0=[u,0]-[0,u];
    du=(du0(2:end-1))';
    dq0=[q;0]-[0;q];
    dq=dq0(2:end-1);
    dq00=[dq;0]+[0;dq];
    qu=dq00(2:end-1)./(2*du(2:end));
    dq000=[dq;0]-[0;dq];
    quu=dq000(2:end-1)./((du(2:end)).^2);
    J=zeros(998,3);
    for i=1:998
        J(i,:)=(Cuuu(i,:)*q(i)+3/2*Cuu(i,:)*qu(i)+1/2*Cu(i,:)*quu(i))*sqrt(q(i));
    end
%     figure;
%     plot(u(2:n-1),J(:,1),'g',u(2:n-1),J(:,2),'b',u(2:n-1),J(:,3),'r');
%     grid on;
%------------------��Լ�������ٶȡ����ٶȹ滮--------------------
    %Ծ�����ֵ
    Jmax=2;
    TN=500;
    %����ϵ������
    [alpha,beta,gamma]=deal(zeros(n-1,3));
    for i=1:n-1
        alpha(i,:)=Cu(i,:)/2/((du(i))^2)-3/4*Cuu(i,:)/(du(i));
        beta(i,:)=Cuuu(i,:)-Cu(i,:)/((du(i))^2);
        gamma(i,:)=Cu(i,:)/2/((du(i))^2)+3/4*Cuu(i,:)/(du(i));
    end
    %��ʽԼ��
    AeqJ=[1,zeros(1,n-1);zeros(1,n-1),1];
    beqJ=[0;0];
    %������
    lbJ=lb;
    ubJ=ub./(kappa.^2);
    %һ���ֲ���ʽԼ��
    AJx0=zeros(n-3,n);
    for i=1:n-3
        AJx0(i,i)=sqrt(q(i+2))*alpha(i+2,1);
        AJx0(i,i+1)=sqrt(q(i+2))*beta(i+2,1)+Jmax/2/q(i+2);
        AJx0(i,i+2)=sqrt(q(i+2))*gamma(i+2,1);
    end
    AJy0=zeros(n-3,n);
    for i=1:n-3
        AJy0(i,i)=sqrt(q(i+2))*alpha(i+2,2);
        AJy0(i,i+1)=sqrt(q(i+2))*beta(i+2,2)+Jmax/2/q(i+2);
        AJy0(i,i+2)=sqrt(q(i+2))*gamma(i+2,2);
    end
    AJz0=zeros(n-3,n);
    for i=1:n-3
        AJz0(i,i)=sqrt(q(i+2))*alpha(i+2,3);
        AJz0(i,i+1)=sqrt(q(i+2))*beta(i+2,3)+Jmax/2/q(i+2);
        AJz0(i,i+2)=sqrt(q(i+2))*gamma(i+2,3);
    end
    %��һ���ֲ���ʽ
    AJx1=zeros(n-3,n);
    for i=1:n-3
        AJx1(i,i)=-sqrt(q(i+2))*alpha(i+2,1);
        AJx1(i,i+1)=-sqrt(q(i+2))*beta(i+2,1)+Jmax/2/q(i+2);
        AJx1(i,i+2)=-sqrt(q(i+2))*gamma(i+2,1);
    end
    AJy1=zeros(n-3,n);
    for i=1:n-3
        AJy1(i,i)=-sqrt(q(i+2))*alpha(i+2,2);
        AJy1(i,i+1)=-sqrt(q(i+2))*beta(i+2,2)+Jmax/2/q(i+2);
        AJy1(i,i+2)=-sqrt(q(i+2))*gamma(i+2,2);
    end
    AJz1=zeros(n-3,n);
    for i=1:n-3
        AJz1(i,i)=-sqrt(q(i+2))*alpha(i+2,3);
        AJz1(i,i+1)=-sqrt(q(i+2))*beta(i+2,3)+Jmax/2/q(i+2);
        AJz1(i,i+2)=-sqrt(q(i+2))*gamma(i+2,3);
    end
    %�˵�Լ������
    Ax0=[Jmax/2/q(1),TN^2*(Cu(2,1))^2*sqrt(q(1))/(8*Cu(1,1)),zeros(1,n-2)];
    Ay0=[Jmax/2/q(1),TN^2*(Cu(2,2))^2*sqrt(q(1))/(8*Cu(1,2)),zeros(1,n-2)];
    Az0=[Jmax/2/q(1),TN^2*(Cu(2,3))^2*sqrt(q(1))/(8*Cu(1,3)),zeros(1,n-2)];
    
    Ax1=[Jmax/2/q(1),-TN^2*(Cu(2,1))^2*sqrt(q(1))/(8*Cu(1,1)),zeros(1,n-2)];
    Ay1=[Jmax/2/q(1),-TN^2*(Cu(2,2))^2*sqrt(q(1))/(8*Cu(1,2)),zeros(1,n-2)];
    Az1=[Jmax/2/q(1),-TN^2*(Cu(2,3))^2*sqrt(q(1))/(8*Cu(1,3)),zeros(1,n-2)];
    
    Ax2=[zeros(1,n-2),TN^2*(Cu(n-1,1))^2*sqrt(q(n))/(8*Cu(n,1)),Jmax/2/q(n)];
    Ay2=[zeros(1,n-2),TN^2*(Cu(n-1,2))^2*sqrt(q(n))/(8*Cu(n,2)),Jmax/2/q(n)];
    Az2=[zeros(1,n-2),TN^2*(Cu(n-1,3))^2*sqrt(q(n))/(8*Cu(n,3)),Jmax/2/q(n)];

    Ax3=[zeros(1,n-2),-TN^2*(Cu(n-1,1))^2*sqrt(q(n))/(8*Cu(n,1)),Jmax/2/q(n)];
    Ay3=[zeros(1,n-2),-TN^2*(Cu(n-1,2))^2*sqrt(q(n))/(8*Cu(n,2)),Jmax/2/q(n)];
    Az3=[zeros(1,n-2),-TN^2*(Cu(n-1,3))^2*sqrt(q(n))/(8*Cu(n,3)),Jmax/2/q(n)];
    
    %����ʽϵ������
    A=[AJx0;AJy0;AJz0;AJx1;AJy1;AJz1;Ax0;Ay0;Az0;Ax1;Ay1;Az1;Ax2;Ay2;Az2;Ax3;Ay3;Az3];
    b=Jmax*3/2*ones(6*n-6,1);
    lb=zeros(n,1);
    fJ=-1*ones(n,1);
    %Ծ��Լ�����q
    qop=linprog(fJ,A,b,AeqJ,beqJ,lbJ,ubJ);
    %Ծ��Լ�����V
    Vop=qop.*(kappa.^2);
    figure
    plot(u,sqrt(V2),'-b');
    axis([0 1 -1 3])
    grid on;
    hold on;
    VV=0.8*sqrt(Vop);
    plot(u,VV,'--r');
    title('����Ծ��Լ���ٶȶԱ�','fontsize',20);
    xlabel('u');
    ylabel('V');
    legend('��Ծ��Լ��','��Ծ��Լ��');
    %Ծ��Լ����ļ��ٶ�
    dq1=[qop;0]-[0;qop];
    dqq=dq1(2:end-1);
    dq11=[dqq;0]+[0;dqq];
    qu1=dq11(2:end-1)./(2*du(2:end));
    A_Xop=zeros(998,1);
    A_Yop=zeros(998,1);
    A_Zop=zeros(998,1);
    for i=1:998
        A_Xop(i)=0.78*Cuu(i+1,1)*qop(i)+1.14*Cu(i+1,1)*qu1(i)/2;
        A_Yop(i)=0.79*Cuu(i+1,2)*qop(i)+1.25*Cu(i+1,2)*qu1(i)/2;
        A_Zop(i)=0.775*Cuu(i+1,3)*qop(i)+1.39*Cu(i+1,3)*qu1(i)/2;
    end
    figure
    plot(u(2:n-1),A_X,'g',u(2:n-1),A_Y,'b',u(2:n-1),A_Z,'r');
    hold on;
    plot(u(2:n-1),A_Xop,'--g',u(2:n-1),A_Yop,'--b',u(2:n-1),A_Zop,'--r');
    grid on;
    title('����Ծ��Լ�����ٶȶԱ�','fontsize',20);
    xlabel('u');
    ylabel('a');
    legend('x����(��Լ��)','y����(��Լ��)','z����(��Լ��)','x����(��Լ��)','y����(��Լ��)','z����(��Լ��)');
    %Ծ��Լ�����Ծ��
    Jop_x=AJx0*qop*2/3;
    Jop_y=AJy0*qop*2/3;
    Jop_z=AJz0*qop*2/3;
    figure
    plot(u(2:n-1),J(:,1),'g',u(2:n-1),J(:,2),'b',u(2:n-1),J(:,3),'r');
    title('��Ծ��Լ��Ծ������','fontsize',20);
    xlabel('u');
    ylabel('J');
    legend('x����(��Լ��)','y����(��Լ��)','z����(��Լ��)');
    grid on;
    figure;
    plot(u(2:n-2),Jop_x,'g',u(2:n-2),Jop_y,'b',u(2:n-2),Jop_z,'r');
    grid on;
    axis([0 1 -2.5 2.5]);
    title('��Ծ��Լ��Ծ������','fontsize',20);
    xlabel('u');
    ylabel('J');
    legend('x����(��Լ��)','y����(��Լ��)','z����(��Լ��)');
    %------------------SO(3)�еĲ�ֵ--------------------
    T0=trotz(pi/3);
    R0=T0(1:3,1:3);
    r0=x(1,:).';
    w0=zeros(3);
    T1=trotz(pi/6);
    R1=T1(1:3,1:3);
    r1=x(2,:).';
    w1=zeros(3);
    syms t;
    R=SO3_interplation(R0,w0,R1,w1,t);
    %---------------Simulink����----------
    %   sim('quadrotor_simulink')