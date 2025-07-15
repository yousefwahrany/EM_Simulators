clear all
close all
% MATLAB script to calculate the integral based on user input
f = 300e6;
c = 3*10^8;
mu_o = 4*pi*10^-7;
% Ask the user for input values
x1 = -1; %input('Enter the start point of the sheet: ');
x2 = 1; %input('Enter the end point of the sheet: ');
N = 101; %input('Enter the number of points to be calculated: ');
ko = 2*pi*f/c;
l = 21;

% Body(1, :) = linspace(-0.25, 0.25, l);
% Body(2, :) = -1 - 2 * abs(Body(1, :));  % Peak at (0,1), linearly decreasing

% Body(1, :) = -0.5:0.05:0.5;
% Body(2, :) = -Body(1, :).^2;

Body(1,:) = linspace(-0.25,0.25,11);
Body(2,:) = 0*Body(1,:);

x(1,:) = [1 1 1 1 1 1] * -0.25;
x(2,:) = linspace(-0.25,0,6);
x(:, end) = [];

y(1,:) = [1 1 1 1 1 1] * 0.25;
y(2,:) = linspace(0, -0.25,6);
y(:, 1) = [];

Body = [x, Body, y];
Body = -Body;

% Body(1, :) = -0.5:0.05:0.5;
% Body(2, :) = sin(2*pi*Body(1, :));

% Body(1, :) = -0.5:0.05:0.5;
% Body(2, :) = Body(1, :).^2;

Body_mid = (Body(:, 1:end-1) + Body(:, 2:end)) / 2;
N = size(Body_mid, 2);
% Initialize S matrix
Z = zeros(N, N);

% Fill the S matrix
for m = 1:N
    for n = 2:N+1
        Z(m, n - 1) = Hankel_integral_2D(Body(:, n - 1), ...
            Body(:, n), Body_mid(:, m), ko);
    end
end

E_surface = exp(1i * ko * Body_mid(2, :)');
Z = Z * -pi*f*mu_o/2;
J = -inv(Z) * E_surface;

plot(linspace(-0.5,0.5,l-1), abs(J)*377, 'bo-', 'LineWidth', 1); % Blue solid line with 2px width
grid on;
grid minor;

% Add labels and title
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('J/|H|', 'FontSize', 12, 'FontWeight', 'bold');

figure;
m = length(J);
plot(linspace(-0.5,0.5,l-1), [unwrap(angle(J(1:m/2))); flip(unwrap(angle(J(1:m/2))))] , 'bo-', 'LineWidth', 1); % Blue solid line with 2px width
grid on;
grid minor;

% Add labels and title
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('phase in degrees', 'FontSize', 12, 'FontWeight', 'bold');


% imagesc(Body_mid(1,:), Body_mid(2,:), abs(J));

% calculate E everywhere
No = 200;
x_0 = linspace(-2, 2, No);
y_0 = linspace(-2, 2, No)';
E = 0;


E_inc = exp(1i * ko * y_0);
E_inc = repmat(E_inc, 1, No);

for k = 1:No
    parfor j = 1:No
        E = 0;
        for i = 1:N
            E = E + J(i)*calculate_E_2D(Body(:, i), Body(:, i+1),...
                x_0(j), y_0(k), ko);
        end
        E_J(k, j) = E;
        
    end
end

E_J = E_J * -pi*f*mu_o/2;
E_space = E_J + E_inc;

figure;
plot(x_0, abs(E_space))
figure;
imagesc(x_0, y_0, abs(E_space));
colorbar; % Add color bar to show scale
colormap(hot); % Change colormap (options: jet, hot, cool, parula, etc.)
set(gca, 'YDir', 'normal');
% caxis([-1 1]);
% Add title and labels
title('E everywhere');
% xlabel('X Axis');
% ylabel('Y Axis');
hold on 
plot(Body(1, :), Body(2, :), 'LineWidth', 3)

figure;
imagesc(x_0, y_0, abs(E_J));
colorbar; % Add color bar to show scale
colormap(hot); % Change colormap (options: jet, hot, cool, parula, etc.)
set(gca, 'YDir', 'normal');
% caxis([-1 1]);
% Add title and labels
title('E generated');
% xlabel('X Axis');
% ylabel('Y Axis');
hold on 
plot(Body(1, :), Body(2, :), 'LineWidth', 3)





