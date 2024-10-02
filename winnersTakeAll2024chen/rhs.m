function [dxdt,s]=rhs(t,x,p)
    s=struct();
    dxdt=zeros(size(x));
    for i=1:p.N
    for j=1:p.N
        dxdt(i)=dxdt(i)+p.A(i,j)*(x(i)-x(j))*x(i)*x(j);
    end
    end

end