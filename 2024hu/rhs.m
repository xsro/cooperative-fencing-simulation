%% 实现
function [dxdt,s]=rhs(t,x,p)
    s=struct();
    s.t=t;  % 这句不用
    x0=x(1:2);
    v0=x(3:4);
    u0=p.s1*x0;
    states=reshape(x(5:end),[],p.N);
    dstates=zeros(size(states));
    for i=1:p.N
        xi=states(1:2,i);
        vi=states(3:4,i);
        epsiloni=states(5:6,i);
        zetai=states(7:8,i);
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
            alpha=1/(dij-p.min_distance)-1/(p.max_distance-p.min_distance);
            repulse=repulse+alpha*xij/vecnorm(xij);
        end

        ei=xi-x0;
        ui=-p.k(1)*xi-p.k(2)*vi-p.k(3)*epsiloni-p.k(4)*zetai+p.k(5)*repulse;
        depsiloni=zetai;
        dzetai=p.s1*epsiloni+ei-p.k(5)*repulse;
        dstates(1:2,i)=vi;
        dstates(3:4,i)=ui;
        dstates(5:6,i)=depsiloni;
        dstates(7:8,i)=dzetai;
    end
    dxdt=[v0;u0;reshape(dstates,[],1)];
end