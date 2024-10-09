function normalized_angle=normalize_angle(angle)
% 使用 mod 函数将角度转换到 -2*pi 到 2*pi 范围，然后调整到 0 到 2*pi 范围  
normalized_angle = mod(angle, 2*pi);  
if normalized_angle < 0  
    normalized_angle = normalized_angle + 2*pi;  
elseif normalized_angle == -0 % 处理 -0 的情况，使其变为 +0  
    normalized_angle = 0;  
end
end