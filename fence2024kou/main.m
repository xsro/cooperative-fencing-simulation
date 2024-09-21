%% 参数定义
params=struct();
params.x0=@(t)[sin(t)+t;cos(t)];
params.v0=@(t)[cos(t)+1;-sin(t)];
params.u0=@(t)[-sin(t);-cos(t)];
params.L=2;
agents=[-7 7 7 -7;-7 -7 7 7]; %智能体位置
params.max_distance=10;       %邻居距离
params.min_distance=2;        %避障距离
params.k=[2.2 6 0.1 3 20];    %控制器增益
params.lambda=[2 1.5 1];      %观测器增益
params.N=size(agents,2);      %智能体个数
params.alpha_max=1e3;
tfinal=15;

initial=reshape([agents;rand(8,params.N)],[],1);      % 闭合多智能体系统所有状态
[dxdt0,s0]=rhs(0,initial,params);  % 
idx=reshape(1:length(initial),[],params.N);
%% 运行仿真
opt=odeset("OutputSel",idx(7,:),"OutputFcn","odeplot");
[t,x]=ode45(@(t,x)rhs(t,x,params),linspace(0,tfinal,1000),...
    initial,opt);
x0=params.x0(t')';
v0=params.v0(t')';
u0=params.u0(t')';


%% convergence of the observer
tiledlayout(3,1)
nexttile
hold on;
for i=1:params.N
    plot(t,x(:,idx(5,i)));
end
title("z_i")
nexttile
hold on;
for i=1:params.N
    plot(t,x(:,idx(7,i))-v0(:,1));
end
title("the estimation of the target's velocity")
nexttile
hold on;
for i=1:params.N
    plot(t,x(:,idx(9,i))-u0(:,1));
end
title("the estimation of the target's accelaration")


%% 绘制30秒时的结果
fig=figure();hold on;
h=struct();
iend=sum(t<30);
h.target=plot(x0(1:iend,1),x0(1:iend,2),"k-");
h.ftarget=plot(x0(iend,1),x0(iend,2),"k","Marker","square","MarkerFaceColor","black","MarkerSize",12);
h.agents=plot(x(1:iend,idx(1,:)),x(1:iend,idx(2,:)),'-',"Color",[252, 157, 154]/256);
h.fagents=plot(x(iend,idx(1,:)),x(iend,idx(2,:)),"ro","MarkerFaceColor","red","MarkerSize",10);
legend([h.ftarget h.fagents],["target","agents"]);
hold on;
axis equal








