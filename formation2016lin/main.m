params=struct();
w=[1 2 3 6 9 8 7 4 4 6 2 5 5 8 5 5 4 6];
t=[2 3 6 9 8 7 4 1 7 3 5 2 8 5 1 9 6 4 ];
params.G=digraph(w,t);
plot(params.G)

params.N=9;

params.w=zeros(9,9);
params.w(1,4) = 6.7016 - 0.9582j; params.w(1,5) = -2.8717 + 3.8299j;
params.w(2,1) = -0.2767 + 1.1172j;params.w(2,5) = -1.1172 - 0.2767j; 
params.w(3,2) = 5.5818 - 0.6142j; params.w(3,6) = 0.6142 + 5.5818j; 
params.w(4,6) = 1.7128 + 2.1726j; params.w(4,7) = 4.3452 - 3.4257j; 
params.w(5,2) = -2.6901;          params.w(5,8) = -2.6901; 
params.w(6,3) = 6.0798 + 0.0326j; params.w(6,4) = -0.0163 + 3.0399j; 
params.w(7,4) = -3.9112 - 2.6227j;params.w(7,8) = -2.6227 + 3.9112j; 
params.w(8,5) = -1.8900 + 3.0397j;params.w(8,9) = 3.0397 + 1.8900j;
params.w(9,5) = 1.7471 + 6.1059j; params.w(9,6) = 4.3587 - 7.8530j;
params.d=[9 -0.5 2 4 -3 4 -4 5 3];

params.k=1;

initial=1*(1:9)'+rand(9,1)*1j;
rhs(0,initial,params)
[t,x]=ode45(@(t,x)rhs(t,x,params),linspace(0,10,1000),initial);
figure;hold on;
for i=1:params.N
    plot(real(x(end,i)),imag(x(end,i)),"o","MarkerFaceColor","r","MarkerSize",10);
    plot(real(x(end,i)),imag(x(end,i)),"MarkerSize",10);
    plot(real(x(:,i)),imag(x(:,i)),"-");
end
axis equal
