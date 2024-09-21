%% 参数定义
params=struct();
target=[2;8;0.5;0.5];         %目标位置
agents=[-7 7 7 -7;-7 -7 7 7]; %智能体位置
params.max_distance=10;       %邻居距离
params.min_distance=2;        %避障距离
params.s1=-0.1;
params.k=[2.2 6 0.1 3 20];    %控制器增益
params.N=size(agents,2);      %智能体个数

initial=reshape([agents;zeros(6,params.N)],[],1);      % 闭合多智能体系统所有状态
[dxdt0,s0]=rhs(0,[target;initial],params);  % 
idx=reshape(5:4+length(initial),[],params.N);
%% 运行仿真
opt=odeset("OutputSel",idx(1,:),"OutputFcn","odeplot");
[t,x]=ode45(@(t,x)rhs(t,x,params),[0,80],...
    [target;initial],opt);



%%
fig=figure();hold on;
h=struct();
iend=sum(t<30);
h.target=plot(x(1:iend,1),x(1:iend,2),"k-");
h.agents=plot(x(1:iend,5:8:end),x(1:iend,6:8:end),'-',"Color",[252, 157, 154]/256);
h.ftarget=plot(x(iend,1),x(iend,2),"k","Marker","square","MarkerFaceColor","black","MarkerSize",12);
h.fagents=plot(x(iend,5:8:end),x(iend,6:8:end),"ro","MarkerFaceColor","red","MarkerSize",10);
legend([h.ftarget h.fagents],["target","agents"]);
hold on;
axis equal


%% dynamic
for i=1:length(t)
    if ~isvalid(fig)
        break
    end
    h.target.XData=x(1:i,1);h.target.YData=x(1:i,2);
    h.ftarget.XData=x(i,1);h.ftarget.YData=x(i,2);
    for a=1:params.N
        step=8*(a-1);
        h.agents(a).XData=x(1:i,5+step);h.agents(a).YData=x(1:i,6+step);
    end
    h.fagents.XData=x(i,5:8:end);h.fagents.YData=x(i,6:8:end);
    title(sprintf("t=%.2f",t(i)))
    drawnow limitrate
    pause(0.1)
    if mod(i,3)==0
        exportgraphics(gca,"hu2024labelfree.gif","Append",i>1)
    end
end







