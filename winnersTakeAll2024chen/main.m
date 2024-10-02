params=struct();
params.N=10;
G=graph(1:params.N,[2:params.N 1]);
% G=graph(ones(params.N)-diag(ones(params.N,1)));
params.A=full(adjacency(G));
initial=log(1:params.N);
rhs(0,initial,params);


[t,x]=ode45(@(t,x)rhs(t,x,params),linspace(0,3,1000),initial);
plot(t,x)