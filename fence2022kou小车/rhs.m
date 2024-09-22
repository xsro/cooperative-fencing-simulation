%% 实现
function [dxdt,s]=rhs(t,x,p)
    s=struct("u",zeros(1,p.N),"w",zeros(1,p.N));
    states=reshape(x,[],p.N);
    dstates=zeros(size(states));
    r0=p.r0(t);
    for i=1:p.N
        ri=states(1:2,i);
        thetai=states(3,i);
        vi=states(4:5,i);
        ri2=ri+[cos(thetai);sin(thetai)]*p.offset;
        repulse=zeros(2,1);
        for j=1:p.N
            if i==j
                continue
            end
            rj=states(1:2,j);
            thetaj=states(3,j);
            rj2=rj+[cos(thetaj);sin(thetaj)]*p.offset;
            rij=ri2-rj2;
            dij=vecnorm(rij);
            if dij>p.max_distance
                continue
            end
            alpha=1/(dij-p.min_distance)-1/(p.max_distance-p.min_distance);
            repulse=repulse+alpha*rij/vecnorm(rij);
        end
        Q=diag([1 p.offset]);
        R=[cos(thetai) -sin(thetai);
           sin(thetai)  cos(thetai)];
        ui0=-p.k*(ri2-r0)+repulse+vi;
        ui=inv(Q)*inv(R)*ui0;
        s.u(i)=ui(1);s.w(i)=ui(2);
        dstates(1:2,i)=[cos(thetai);sin(thetai)]*ui(1);
        dstates(3,i)=ui(2);
        dstates(4:5,i)=-p.k*(ri2-r0)+repulse;
    end
    dxdt=reshape(dstates,[],1);
end