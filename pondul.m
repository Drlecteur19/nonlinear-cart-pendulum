%By [taourirt lamri]Dr_lecter
% 14/11/2025 
%inverted pundulum 
% the output will be the displacement of carts and the angel in pundulum  
function dx = pondule(t, x, F)
    % States
    X   = x(1);   % cart position
    Xd  = x(2);   % cart velocity
    th  = x(3);   % pendulum angle (0 = upright)
    thd = x(4);   % pendulum angular velocity

    % Parameters
    M = 0.5;     % cart mass
    m = 0.2;     % pendulum mass
    l = 0.3;     % pendulum length to center of mass
    g = 9.81;

    % Denominator
    den = M + m - m*cos(th)^2;

    % Nonlinear dynamics
    Xdd  = (F + m*sin(th)*(l*thd^2 + g*cos(th))) / den;

    thdd = (-F*cos(th) - m*l*thd^2*cos(th)*sin(th) ...
           - (M+m)*g*sin(th)) / (l * den);

    dx = [Xd; Xdd; thd; thdd];
end

