function [dxdt,s]=rhs(t,x,p)
    states=reshape(x,3,[]);
    dstates=zeros(size(states));
    p.N=size(states,2);
    s=struct();

    for i=1:p.N
        ui=zeros(2,1);
        if i>p.M
            
        else
            hi=p.h(t,i);
            xi=states(:,i);
            hdi=p.hd(t,i);
            neighbors= findsourcenode(p.G,i);
            for j= neighbors'
                xj=states(:,j);
                if j<=p.M
                    hj=p.h(t,j);
                    ui=ui+p.K*(xi-hi-(xj-hj));
                else
                    ui=ui+p.K*(xi-hi-xj);
                end
                vi=-p.Btilde*(p.A*hi-hdi);
                ui=ui+vi;
            end
        end
        dstates(:,i)=p.A*states(:,i)+p.B*ui;
    end
    dxdt=dstates(:);
end