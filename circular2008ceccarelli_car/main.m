params=struct();
params.v=1;
params.alpha_v=pi/4;
params.ds=3;
params.dl=12;
params.psi=7/4*pi;
params.d0=10;
params.cb=2;
params.cv=2;
params.kb=0.05;
params.kv=0.09;
params.rho0=12;
params.beacon=@(t)[10+0.1*t;1];

vehicles=[zeros(1,8);linspace(-10,20,8);zeros(1,8)];
params.N=size(vehicles,2);
initial=vehicles(:);

[d0,s0]=rhs(0,initial,params);

idx=reshape(1:length(initial),3,[]);

%%
opt=odeset("outputfcn","odeplot");
[t,x]=ode45(@(t,x)rhs(t,x,params),linspace(0,1000,1e4),initial);
%%

%%
figure();hold on;
h=arrayfun(@(i)plot(x(:,idx(1,i)),x(:,idx(2,i)),'-'),1:params.N);

for i=1:params.N
    xi=x(end,idx(1,i));
    yi=x(end,idx(2,i));
    thetai=x(end,idx(3,i));
    d=2;
    xc=[xi+2*d*cos(thetai) xi+0.5*d*cos(thetai-pi/2) xi+0.5*d*cos(thetai+pi/2) ];
    yc=[yi+2*d*sin(thetai) yi+0.5*d*sin(thetai-pi/2) yi+0.5*d*sin(thetai+pi/2)];
    h2(i)=patch(xc,yc,h(i).Color);
end
% legend(h2,"vehicle"+(1:params.N))
axis equal

