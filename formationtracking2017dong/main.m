params=struct();
params.A=[0 1 1;1 2 1;-2 -6 -3];
params.B=[0 1;-1 0; 0 0];
params.h=@(t,i)[15*sin(t+(i-1)*pi/5);-15*cos(t+(i-1)*pi/5);30*cos(t+(i-1)*pi/5)];
params.hd=@(t,i)[15*cos(t+(i-1)*pi/5);15*sin(t+(i-1)*pi/5);-30*sin(t+(i-1)*pi/5)];
params.K=[1.0053 3.9625 0.5575;-1.2320 -1.0053 -0.3637];
params.Bbar=[0 0 1];
params.Btilde=[0 -1 0;1 0 0];
params.delta=0.55;
params.G=digraph([1 3 4 2 8 8 7  7  9 10 13 12 11 13 12 11],...
                 [3 4 5 1 9 7 8 6  10  8  2  2  2  8  8  8]);

vehicles=[zeros(3,10) 3*rand(3,3)];
params.N=size(vehicles,2);
params.M=10;
initial=vehicles(:);

[d0,s0]=rhs(0,initial,params);

idx=reshape(1:length(initial),3,[]);

%%
opt=odeset("outputfcn","odeplot");
[t,x]=ode45(@(t,x)rhs(t,x,params),linspace(0,100,1e3),initial);
%%

it=sum(t<100);
figure();hold on;
h=struct();
h.traj=cell(params.N);
for i=1:params.N
    if i>params.M
        h.traj{i}=plot3(x(it,idx(1,i)),x(it,idx(2,i)),x(it,idx(3,i)),"kp");
    else
        h.traj{i}=plot3(x(it,idx(1,i)),x(it,idx(2,i)),x(it,idx(3,i)),"o");
    end
end
xlabel("x");ylabel("y");zlabel("z");
axis equal
return
%%
view(3)
view([222 46])
for it=1:length(t)
    title(sprintf("t=%.2f",t(it)));
    if t(it)>10
        break
    end
    for i=1:params.N
        h.traj{i}.XData=x(it,idx(1,i));
        h.traj{i}.YData=x(it,idx(2,i));
        h.traj{i}.ZData=x(it,idx(3,i));
    end
    axis([ -60   60   -60   60  -60   60])
    drawnow limitrate
    grid on;
    pause(0.1)
    exportgraphics(gca,"formationtracking.gif","Append",it~=1);
end