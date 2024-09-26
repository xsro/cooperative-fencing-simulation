function [dxdt,s]=rhs(t,x,p)
    s=struct();
    dxdt=zeros(5,1);
    z=x(3:5);
    dxdt(1)=z(1);
    dxdt(2)=z(2);
    if z(2)^2+z(1)^2>0
        alpha=atan2(z(2),z(1));
    else
        alpha=0;
    end
    rho=norm(x(1:2)-p.target);
    ym=0.5*rho^2;
    u=z(1);
    v=z(2);
    dxdt(1)=u;
    dxdt(2)=v;
    dxdt(3)=p.k(1)*(p.Ud*cos(alpha)-z(1))-z(2)*sqrt(z(1)^2+z(2)^2)*(1/p.rhod+p.k(2)*(-p.k(3)*z(3)+ym));
    dxdt(4)=p.k(1)*(p.Ud*sin(alpha)-z(2))+z(1)*sqrt(z(1)^2+z(2)^2)*(1/p.rhod+p.k(2)*(-p.k(3)*z(3)+ym));
    dxdt(5)=-p.k(3)*z(3)+ym;



end