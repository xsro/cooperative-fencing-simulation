%% 参数定义
params=struct();
params.target=[3;10];        %目标位置
agents=[0 0 5 5;0 5 0 5];    %智能体位置
params.max_distance=3;       %邻居距离
params.min_distance=1;       %避障距离
params.delta=deg2rad(10);    %共线容许最大角度
params.epsilon=0.05;         %旋转项幅值
params.k=1;                  %目标吸引增益
params.N=size(agents,2);     %智能体个数

initial=reshape(agents,[],1);      % 闭合多智能体系统所有状态
[dxdt0,s0]=rhs(0,initial,params);  % 

%% 运行仿真
opt=odeset("OutputSel",[1,3,5,7],"OutputFcn","odeplot");
[t,x]=ode45(@(t,x)rhs(t,x,params),[0,10],...
    reshape(initial,[],1),opt);



%%
figure(1);
plot(x(:,1:2:end),x(:,2:2:end));
hold on;
plot(3,10,"x");
axis equal







