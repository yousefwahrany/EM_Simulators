clear all
% MATLAB script to calculate the integral based on user input
f = 300e6;
c = 3*10^11;
mu_o = 4*pi*10^-7;
% Ask the user for input values
x1 = -1; %input('Enter the start point of the sheet: ');
x2 = 1; %input('Enter the end point of the sheet: ');
N = 101; %input('Enter the number of points to be calculated: ');
ko = 2*pi*f/c;


% Body(1, :) = -0.5:0.05:0.5;
% Body(2, :) = Body(1, :).^2;

Body(1,:) = -1.05:0.1:1.05;
Body(2,:) = 0*Body(1,:);

Body_mid = (Body(:, 1:end-1) + Body(:, 2:end)) / 2;
N = size(Body_mid, 2);
% Initialize S matrix
Z = zeros(N - 1, N - 1);

% Fill the S matrix
for m = 1:N
    for n = 2:N+1
        if Body_mid(1, m) == 0 || (Body(1, n - 1) == -0.05 && Body(1, n) == 0.05)
            continue;
        end
        Z(m, n - 1) =  Hankel_integral_2D(Body(:, n - 1), ...
            Body(:, n), Body_mid(:, m), ko);
    end
end

E_surface = exp(1i * ko * Body_mid(2, :)');
Z = Z * -pi*f*mu_o/2;
J = -inv(Z) * E_surface;
% 
% imagesc(Body_mid(1,:), Body_mid(2,:), abs(J));

% calculate E everywhere
No = 200;
x_0 = linspace(-1.05, 1.05, No);
y_0 = linspace(-1.5, 0.5, No)';
E = 0;

E_inc = exp(1i * ko * y_0);
E_inc = repmat(E_inc, 1, No);

for k = 1:No
    parfor j = 1:No
        E = 0;
        for i = 1:N
            
            if (Body(1, i) == -0.05 && Body(1, i+1) == 0.05)
                continue;
            end
            
            E = E + J(i)*calculate_E_2D(Body(:, i), Body(:, i+1),...
                x_0(j), y_0(k), ko);
        end
        E_J(k, j) = E;
        
    end
end

E_J = E_J * -pi*f*mu_o/2;
E_space = E_J + E_inc;


plot(x_0, abs(E_space))
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
plot(-Body(1, :), -Body(2, :))




