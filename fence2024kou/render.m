



%%

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

return
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