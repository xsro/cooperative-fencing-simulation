%% 实现
function [dxdt,s]=rhs(t,x,p)
    s=struct();
    s.t=t;  % 这句不用
    x0=p.x0(t);
    v0=p.v0(t);
    u0=p.u0(t);
    states=reshape(x,[],p.N);
    dstates=zeros(size(states));
    for i=1:p.N
        xi=states(1:2,i);
        vi=states(3:4,i);
        x0hat=states(5:6,i);
        v0hat=states(7:8,i);
        u0hat=states(9:10,i);
        sigmai=x0-xi;
        alpha0=-p.lambda(1)*p.L^(1/3)*sig(x0hat-sigmai,2/3)+v0hat;
        alpha1=-p.lambda(2)*p.L^(1/2)*sig(v0hat-alpha0,1/2)+u0hat;
        alpha2=-p.lambda(3)*p.L*sig(u0hat-alpha1,0);
        dstates(5:6,i)=alpha0-vi;
        dstates(7:8,i)=alpha1;
        dstates(9:10,i)=alpha2;
        

        repulse=zeros(2,1);
        for j=1:p.N
            if i==j
                continue
            end
            xj=states(1:2,j);
            xij=xi-xj;                       %遵从原论文使用xij表示从从j到i
            dij=vecnorm(xij);
            if dij>p.max_distance
                continue
            end
            if dij<p.min_distance
                alpha=inf;
            else
                alpha=1/(dij-p.min_distance)-1/(p.max_distance-p.min_distance);
            end
            if alpha>p.alpha_max
                alpha=p.alpha_max;
            end
            repulse=repulse+alpha*xij/vecnorm(xij);
        end
        
        % ui=-p.k(1)*(xi-x0)-p.k(2)*(vi-v0)+u0+repulse;
        ui=-p.k(1)*(xi-x0)-p.k(2)*(vi-v0hat)+u0hat+repulse;

        dstates(1:2,i)=vi;
        dstates(3:4,i)=ui;
    end
    dxdt=[reshape(dstates,[],1)];

    function y=sig(x,q)
        y=arrayfun(@(a)(abs(a)^q*sign(a)),x);
    end
end