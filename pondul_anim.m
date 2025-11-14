clear; clc; close all;

% Time vector
t = linspace(0, 100, 400);

% Make the cart move left and right (sinusoidal motion)
cart_position = 0.8 * sin(0.8 * t);   % amplitude 0.8 m
%make the pundulum oscilating
pondulum_position = -1.5 * sin(0.8 * t); ;
% Cart visual parameters
cart_width  = 0.4;
cart_height = 0.2;
%pundulum visual parameters
pondul_width =0.1;
pondul_height=0.8;
%% Initial condition
x0 = [0; 0; 10*pi/180; 0];  % small angle

%% Control input (no control)
F = @(t) 0;   % you can later change this to LQR

%% Simulate with ODE45
tspan = [0 10];
[t, X] = ode45(@(t,x) pondul(t, x, F(t)), tspan, x0);

pos   = X(:,1);  % cart position
theta = X(:,3);  % pendulum angle

%% Figure setup
figure('Color','w');
axis equal
grid on
hold on
xlabel('Position (m)')
ylabel('Height (m)')
xlim([-2 2])
ylim([-1 1.5])
title('Cart Moving Left and Right')
% the function plot 

%%ANIMATION
for k = 1:length(t)
    cla;

    % Current cart position
    x = cart_position(k);
    theta= pondulum_position(k)

    % Draw the cart as a rectangle
    rectangle('Position', [x - cart_width/2, 0, cart_width, cart_height], ...
              'FaceColor', [0.2 0.6 1], ...
              'EdgeColor', 'k', ...
              'LineWidth', 2);
    % ------------ REAL PENDULUM COORDINATES -------------
    pivot_x = x;                 % pivot on top of cart
    pivot_y = cart_height/2;

    L = pondul_height;           % length of pendulum

    % End point of pendulum
    px = pivot_x + L * sin(theta);
    py = pivot_y + L * cos(theta);

    % Line (rod)
    plot([pivot_x px], [pivot_y py], 'r', 'LineWidth', 4);

    % Pendulum mass
    plot(px, py, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'y');

    % -----------------------------------------------------
    
     
    drawnow;
    pause(0.01);
   
   
    
end
% %% plot the position 
% 
% figure(2);
% axis equal
% grid on
% hold on
% xlabel('Position (m)')
% ylabel('time (s)')
% xlim([-2 2])
% ylim([-1 1.5])
% title('Cart Moving Left and Right')
% plot(t,theta);

