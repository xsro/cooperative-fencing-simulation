function [dxdt,s]=rhs(t,x,p)
    states=reshape(x,3,[]);
    dstates=zeros(size(states));
    p.N=size(states,2);
    s=struct();
    rb=p.beacon(t);

    for i=1:p.N
        dstates(1,i)=p.v*cos(states(3,i));
        dstates(2,i)=p.v*sin(states(3,i));
        
        rv=states(1:2,i);
        ri=rb-rv;
        rhoi=vecnorm(ri);
        gamma=atan2(ri(2),ri(1))-states(3,i);
        gamma=normalize_angle(gamma);
        if gamma<=p.psi
            alpha_d=gamma;
        else
            alpha_d=gamma-2*pi;
        end
        if rhoi>0
            g=log(((p.cb-1)*rhoi+p.rho0)/(p.cb*p.rho0));%eq 5
            fib=p.kb*g*alpha_d;
        else
            fib=0;
        end
        ui=fib;
        for j=1:p.N
            if j~=i
                rij=states(1:2,j)-states(1:2,i);
                rhoij=vecnorm(rij);
                cond1=rhoij<p.ds;
                gammaij=atan2(rij(2),rij(1))-states(3,i);
                gammaij=normalize_angle(gammaij);
                cond2=(gammaij<p.alpha_v || gammaij>2*pi-p.alpha_v) && rhoij<p.dl;
                if cond1 || cond2
                    if gammaij<=pi
                        beta_d=gammaij;
                    else
                        beta_d=gammaij-2*pi;
                    end
                    g2=log(((p.cv-1)*rhoij+p.d0)/(p.cv*p.d0));
                    fij=p.kv*g2*beta_d;
                    ui=ui+fij;
                else
                    continue
                end
                
            end
        end
        dstates(3,i)=ui;
    end
    dxdt=dstates(:);
end