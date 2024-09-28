function [dxdt,s]=rhs(t,x,p)
    s=struct();
    dxdt=zeros(size(x));
    z=x;
    % eq 15
    for i=1:p.N
        s=0;
        for j=1:p.N
            if i~=j
                s=s+p.w(i,j)*(z(j)-z(i));
            end
        end
        dxdt(i)=p.k * p.d(i)*s;
    end
end