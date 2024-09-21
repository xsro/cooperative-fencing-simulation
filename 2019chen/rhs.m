%% 实现
function [dxdt,s]=rhs(t,x,p)
    s=struct();
    s.t=t;  % 这句不用
    states=reshape(x,[],p.N);
    dstates=zeros(size(states));
    x0=p.target;
    for i=1:p.N
        xi=states(1:2,i);
        attract=p.k*(x0-xi);
        repulse=zeros(2,1);
        impulse=zeros(2,1);
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

            angle_cos=(xj-x0)'*(xi-x0)/vecnorm(xi-x0)/vecnorm(xj-x0);   %计算自身和邻居关于目标的夹角
            angle=acos(angle_cos);
            if angle<p.delta
                impulse=impulse+p.epsilon*rotationMatrix2D(pi/2)*xij/vecnorm(xij);
            end
        end
        dstates(1:2,i)=attract+repulse+impulse;
    end
    dxdt=reshape(dstates,[],1);
    function R=rotationMatrix2D(ang)
        R=[
            cos(ang),sin(ang);
           -sin(ang),cos(ang)];
    end
end