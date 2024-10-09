
%%
figure();hold on;
rb=params.beacon(t(end));
h=struct();colors=lines(params.N);
h.beacon=plot(rb(1),rb(2),"o","MarkerFaceColor","black","MarkerSize",30);
h.vehicle=cell(params.N,2);
for i=1:params.N
    xi=x(end,idx(1,i));
    yi=x(end,idx(2,i));
    thetai=x(end,idx(3,i));
    d=2;
    xc=[xi+2*d*cos(thetai) xi+0.5*d*cos(thetai-pi/2) xi+0.5*d*cos(thetai+pi/2) ];
    yc=[yi+2*d*sin(thetai) yi+0.5*d*sin(thetai-pi/2) yi+0.5*d*sin(thetai+pi/2)];
    h.vehicle{i,1}=patch(xc,yc,colors(i,:));
    h.vehicle{i,2}=plot(x(1,idx(1,i)),x(1,idx(2,i)),'-',"Color",h.vehicle{i,1}.FaceColor);
end
axis equal

iend=sum(t<500);
for it=1:10:iend
    title(sprintf("t=%.2f",t(it)));
    
    rb=params.beacon(t(it));
    h.beacon.XData=rb(1);
    h.beacon.YData=rb(2);
    for i=1:params.N
        xi=x(it,idx(1,i));
        yi=x(it,idx(2,i));
        thetai=x(it,idx(3,i));
        d=2;
        xc=[xi+2*d*cos(thetai) xi+0.5*d*cos(thetai-pi/2) xi+0.5*d*cos(thetai+pi/2) ];
        yc=[yi+2*d*sin(thetai) yi+0.5*d*sin(thetai-pi/2) yi+0.5*d*sin(thetai+pi/2)];
        h.vehicle{i,1}.XData=xc;
        h.vehicle{i,1}.YData=yc;
        h.vehicle{i,2}.XData=x(1:it,idx(1,i));
        h.vehicle{i,2}.YData=x(1:it,idx(2,i));
    end

    axis equal
    drawnow
    pause(0.01)

    exportgraphics(gca,"circular2.gif","Append",i>3)
end