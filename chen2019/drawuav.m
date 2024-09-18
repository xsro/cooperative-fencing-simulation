function drawuav(p,spec,options)
%uavplot 3D uav 绘图（借助plot3）
%  O   O  简单绘制一个无人机
%   \ /   
%    x    
%   / \  
%  O   o
    arguments
        p (3,1) {mustBeNumeric}=[0;0;0] %position
        spec (1,1) string = 'k-'
        %TODO: 目前姿态的实现可能有bug
        options.attitude (3,1) {mustBeNumeric} = [0;0;0]%attitude ψ为偏航角，θ为俯仰角，φ为滚转角 
        options.r (1,1) {mustBeNumeric} = 0.6  % 旋翼半径
        options.l (1,1) {mustBeNumeric} = 1    % 无人机中心到旋翼中心
        options.Rotors (1,1) {mustBeNumeric} = 4    % 无人机旋翼数
        options.RotorStart (1,1) {mustBeNumeric} = pi/4   % 无人机旋翼数
        options.N (1,1) {mustBeNumeric} = 30    % 无人机旋翼使用N个点绘制
        options.frameWidth (1,1)  {mustBeNumeric} = 2
        options.RotorLineWidth (1,1) {mustBeNumeric} = 1
        options.ax (1,1) = gca
    end
    psi=options.attitude(1);the=options.attitude(2);phi=options.attitude(3);
    R = [cos(the)*cos(phi) sin(psi)*sin(the)*cos(phi)-cos(psi)*sin(phi) cos(psi)*sin(the)*cos(phi)+sin(psi)*sin(phi);   %BBF > Inertial rotation matrix
        cos(the)*sin(phi) sin(psi)*sin(the)*sin(phi)+cos(psi)*cos(phi) cos(psi)*sin(the)*sin(phi)-sin(psi)*cos(phi);
        -sin(the)         sin(psi)*cos(the)                            cos(psi)*cos(the)];
    N=options.N;%绘制一个旋翼时的采样点
    data=zeros(3,options.Rotors*N);
    for idx=1:options.Rotors
        angle=options.RotorStart+idx*2*pi/options.Rotors;
        rx=options.l*cos(angle);ry=options.l*sin(angle);
        circle_angle=linspace(angle+pi,angle+3*pi,N);
        data(:,(idx-1)*N+1:idx*N)=[rx+options.r.*cos(circle_angle);ry+options.r.*sin(circle_angle);zeros(size(circle_angle))];
    end
    rotated=R*data;
    % plot3(rotated(1,:),rotated(2,:),rotated(3,:))
    hold(options.ax,"on");
    for idx=1:options.Rotors
        rx=p(1)+[rotated(1,(idx-1)*N+1:idx*N)];
        ry=p(2)+[rotated(2,(idx-1)*N+1:idx*N)];
        rz=p(3)+[rotated(3,(idx-1)*N+1:idx*N)];
        plot3(options.ax,[p(1) rx(1)],[p(2) ry(1)],[p(3) rz(1)],spec,"LineWidth",options.frameWidth);
        plot3(options.ax,rx,ry,rz,spec,'LineWidth',options.RotorLineWidth)
    end
end
