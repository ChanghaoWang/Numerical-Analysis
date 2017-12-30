function varargout = Nurbs_program(varargin)
% NURBS_PROGRAM MATLAB code for Nurbs_program.fig
%      NURBS_PROGRAM, by itself, creates a new NURBS_PROGRAM or raises the existing
%      singleton*.
%
%      H = NURBS_PROGRAM returns the handle to a new NURBS_PROGRAM or the handle to
%      the existing singleton*.
%
%      NURBS_PROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NURBS_PROGRAM.M with the given input arguments.
%
%      NURBS_PROGRAM('Property','Value',...) creates a new NURBS_PROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Nurbs_program_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Nurbs_program_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Nurbs_program

% Last Modified by GUIDE v2.5 08-Jun-2017 21:49:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Nurbs_program_OpeningFcn, ...
                   'gui_OutputFcn',  @Nurbs_program_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Nurbs_program is made visible.
function Nurbs_program_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Nurbs_program (see VARARGIN)

% Choose default command line output for Nurbs_program
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Nurbs_program wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Nurbs_program_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%---------��ȡtxt�����·����-------------------
global n x N Q U u V2 Vop qop Cuu Cu A_X A_Y A_Z du J AJx0 AJy0 AJz0
      x=load('projectdata.txt');
%-------��������·���㷴����Ƶ㣬�������߽�����ֵ������3��NURBS����------
     [N,Q,U]=NURBS(x);%NΪ���ߵ㣬QΪ���Ƶ㣬UΪ�ڵ�����
%      handles.x=x;
%      guidata(hObject,handles);
%      handles.N=N;
%      guidata(hObject,handles);
%      handles.Q=Q;
%      guidata(hObject,handles);
%      handles.U=U;
%      guidata(hObject,handles);
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
    Ts = 0.1;
    %���ٶ����ֵ
    Amax=2;
    %������
    lb=zeros(n,1);
    ub=zeros(n,1);
    rho = zeros(n,1);
    for i =2:n-1 % ��ֹ���ʰ뾶���Բ����㣬��Ϊ��ֹ���ٶ�Ϊ0������Ϊ0
        rho(i) = (norm(Cu(i,:)))^3/norm(cross(Cu(i,:),Cuu(i,:)));
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
    set(handles.edit4,'string','¼���������');




function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.radiobutton2,'value',1);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',0);
set(handles.radiobutton5,'value',0);
global u V2 Vop
cla(handles.axes1);
axes(handles.axes1);
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



% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
 %Ծ��Լ����ļ��ٶ�
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',1);
set(handles.radiobutton4,'value',0);
set(handles.radiobutton5,'value',0);
 global n u qop Cuu Cu A_X A_Y A_Z du
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
    cla(handles.axes1);
    axes(handles.axes1);
    plot(u(2:n-1),A_X,'g',u(2:n-1),A_Y,'b',u(2:n-1),A_Z,'r');
    hold on;
    plot(u(2:n-1),A_Xop,'--g',u(2:n-1),A_Yop,'--b',u(2:n-1),A_Zop,'--r');
    grid on;
    title('����Ծ��Լ�����ٶȶԱ�','fontsize',20);
    xlabel('u');
    ylabel('a');
    legend('x����(��Լ��)','y����(��Լ��)','z����(��Լ��)','x����(��Լ��)','y����(��Լ��)','z����(��Լ��)');


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',1);
set(handles.radiobutton5,'value',0);
global n u J
cla(handles.axes1);
axes(handles.axes1);
plot(u(2:n-1),J(:,1),'g',u(2:n-1),J(:,2),'b',u(2:n-1),J(:,3),'r');
title('��Ծ��Լ��Ծ������','fontsize',20);
xlabel('u');
ylabel('J');
legend('x����(��Լ��)','y����(��Լ��)','z����(��Լ��)');
grid on;

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',0);
set(handles.radiobutton5,'value',1);
global qop AJx0 AJy0 AJz0 u n 
 Jop_x=AJx0*qop*2/3;
 Jop_y=AJy0*qop*2/3;
 Jop_z=AJz0*qop*2/3;
 cla(handles.axes1);
 axes(handles.axes1);
 plot(u(2:n-2),Jop_x,'g',u(2:n-2),Jop_y,'b',u(2:n-2),Jop_z,'r');
 grid on;
 axis([0 1 -2.5 2.5]);
 title('��Ծ��Լ��Ծ������','fontsize',20);
 xlabel('u');
 ylabel('J');
 legend('x����(��Լ��)','y����(��Լ��)','z����(��Լ��)');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x N Q U
cla(handles.axes2);
axes(handles.axes2);
%-------------------����·����----------------------------
     plot3(x(:,1),x(:,2),x(:,3),'ob');
     grid on;
     hold on;
%------------------�������ƶ����-----------------------
%      plot3(Q(:,1),Q(:,2),Q(:,3),'r');
%      hold on;
%----------------����NURBS����-------------------------
     plot3(N(:,1),N(:,2),N(:,3),'g');
     axis([-1.5 1.5 -1.5 1.5 0.2 1.4]);
     title('����·�����µ�NURBS����','fontsize',20);
     legend('·����','NURBS����');
     xlabel('x');
     ylabel('y');
     zlabel('z');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf,'visible','off');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 %SO3=imread('SO3.fig');
 %imshow(SO3);
 global x
 t=linspace(0,22,22);
 x1=[t.',x];
 sim('quadrotor_simulink');
