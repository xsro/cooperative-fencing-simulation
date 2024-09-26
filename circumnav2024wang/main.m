params=struct();
params.rhod=1.5;
params.sigma=0.1;
params.Ud=0.5;
params.k=[0.5 0.6 0.8 0.8];
params.target=[2 3]';

initial=zeros(5,1);

[dxdt0,s0]=rhs(0,initial,params);

[t,x]=ode45(@(t,x)rhs(t,x,params),linspace(0,60,100),initial);

figure;hold on
plot(x(:,1),x(:,2))
p1=plot(params.target(1),params.target(2),"rp","MarkerSize",30,"MarkerFaceColor","red");
axis equal;grid on

p2=plot(x(1,1),x(1,2),"bo","MarkerSize",20,"MarkerFaceColor","blue");
legend([p1 p2],["target","agent"])

for i=1:length(t)
    title(sprintf("t=%.2f",t(i)))
    p2.XData=x(i,1);
    p2.YData=x(i,2);
    drawnow
    pause(0.1)
    exportgraphics(gca,"circumnav2024wang.gif","Append",i>1)
end
