
%% 动态绘制
figure(10);hold on;
X=[min(x(:,1:2:end),[],"all")-1,max(x(:,1:2:end)+1,[],"all")];
Y=[min(x(:,2:2:end),[],"all")-1,max(x(:,2:2:end)+1,[],"all")];
[X,Y]=meshgrid(X,Y);
Z=zeros(size(X));
for i=1:length(t)
    cla;
    title(sprintf("t=%f",t(i)));
    %绘制地面和目标
    surf(X,Y,Z,"FaceColor",[220,220,220]./255,"EdgeColor","none","FaceAlpha",0.5)
    %绘制目标
    drawuav([3,10,0.8],"black","r",0.2,"l",0.4);
    %绘制轨迹
    colors={'r','g','b','cyan'};
    for n=1:4
        plot3(x(1:i,2*n-1),x(1:i,2*n),ones(i,0),colors{n}+"--");
    end
    agents=zeros(5,3);
    for n=1:4
        agents(n,:)=[x(i,2*n-1),x(i,2*n),1];
        drawuav([x(i,2*n-1),x(i,2*n),1],colors{n},"r",0.2,"l",0.4);
    end
    agents(5,:)=agents(1,:);
    plot3(agents(:,1),agents(:,2),agents(:,3),'k')
    grid("on")
    axis equal
    zlim([0 2])
    view([1,1,1])
    pause(0.01)
    if mod(i,5)==0
    exportgraphics(gca,"chen2019.gif","Append",i>3)
    end
end