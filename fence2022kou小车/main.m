%% 参数定义
params=struct();
params.r0=@(t)[t,0]';        %目标位置
params.v0=@(t)[1,0]';        %目标位置
agents=[0 0 5 5;0 5 0 5];    %智能体位置
params.max_distance=3;       %邻居距离
params.min_distance=1;       %避障距离
params.offset=0.01;          %共线容许最大角度
params.k=10;                  %目标吸引增益
params.N=size(agents,2);     %智能体个数
tfinal=30;

initial=reshape([agents;rand(3,params.N)],[],1);      % 闭合多智能体系统所有状态
[dxdt0,s0]=rhs(0,initial,params);  % 
idx=reshape(1:length(initial),[],params.N);

%% 运行仿真
opt=odeset("OutputSel",idx(4,:),"OutputFcn","odeplot");
[t,x]=ode45(@(t,x)rhs(t,x,params),linspace(0,tfinal,1000),...
    reshape(initial,[],1),opt);
r0=zeros(length(t),2);
v0=zeros(length(t),2);
for i=1:length(t)
    r0(i,:)=params.r0(t(i))';
    v0(i,:)=params.v0(t(i))';
end

%% 速度观测
figure;
nexttile
plot(t,x(:,idx(4,:)))
grid on;
nexttile
plot(t,x(:,idx(5,:)))
grid on


return
%% 绘制30秒时的结果
fig=figure();hold on;
h=struct();
iend=sum(t<30);
h.target=plot(r0(1:iend,1),r0(1:iend,2),"k-");
h.ftarget=plot(r0(iend,1),r0(iend,2),"k","Marker","square","MarkerFaceColor","black","MarkerSize",12);
h.agents=plot(x(1:iend,idx(1,:)),x(1:iend,idx(2,:)),'-',"Color",[252, 157, 154]/256);
h.fagents=plot(x(iend,idx(1,:)),x(iend,idx(2,:)),"ro","MarkerFaceColor","red","MarkerSize",10);
legend([h.ftarget h.fagents],["target","agents"]);
hold on;
axis equal







