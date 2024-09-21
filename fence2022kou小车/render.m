
%% 动态绘制
figure(10);clf;hold on;
h=struct();
h.ftarget=quiver(r0(1,1),r0(1,2),v0(1,1),v0(1,2),"Color","black");
theta=x(1,idx(3,:));
h.agents=plot(x(1:end,idx(1,:)),x(1:end,idx(2,:)),'-',"Color",[252, 157, 154]/256);
h.fagents=quiver(x(1,idx(1,:)),x(1,idx(2,:)),cos(theta),sin(theta),"Color","red");
for i=1:length(t)
    title(sprintf("t=%.2f",t(i)));
    h.ftarget.XData=r0(i,1);
    h.ftarget.YData=r0(i,2);
    h.ftarget.UData=v0(i,1);
    h.ftarget.VData=v0(i,2);

    h.fagents.XData=x(i,idx(1,:));
    h.fagents.YData=x(i,idx(2,:));
    theta=x(i,idx(3,:));
    h.fagents.UData=cos(theta);
    h.fagents.VData=sin(theta);

    axis equal
    drawnow
    pause(0.01)
    if mod(i,5)==0
    exportgraphics(gca,"kou2022小车.gif","Append",i>3)
    end
end