clear all
% MATLAB script to calculate the integral based on user input
f = 300e6;
c = 3*10^8;
mu_o = 4*pi*10^-7;
% Ask the user for input values
x1 = -1; %input('Enter the start point of the sheet: ');
x2 = 1; %input('Enter the end point of the sheet: ');
N = 101; %input('Enter the number of points to be calculated: ');
ko = 2*pi*f/c;

Body  = [1,  0.809,  0.309, -0.309, -0.809, -1, -0.809, -0.309,  0.309,  0.809;
          0,  0.588,  0.951,  0.951,  0.588,  0, -0.588, -0.951, -0.951, -0.588];

Body_interpolated = interpolate(Body, 10, 1); 
Body_mid = (Body_interpolated(:, 1:end-1) + Body_interpolated(:, 2:end)) / 2;
N = size(Body_mid, 2);
% Initialize S matrix
Z = zeros(N, N);

% Fill the S matrix
for m = 1:N
    for n = 2:N+1
        Z(m, n - 1) =  Hankel_integral(X(n - 1), X(n), X_mid(m), ko);
    end
end

Z = Z * -pi*f*mu_o/2;
J = -inv(Z) * ones(N, 1);

plot(X_mid, abs(J) * 377)

% calculate V every where
No = 100;
x_0 = linspace(-2, 2, No);
y_0 = linspace(-2, 2, No)';
E = 0;

E_inc = exp(1i * ko * y_0);
E_inc = repmat(E_inc, 1, No);

for k = 1:No
    for j = 1:No
        for i = 1:N
            E = E + J(i)*calculate_E(X(i), X(i+1), x_0(j), y_0(k), ko);
        end
        E_J(k, j) = E;
        E = 0;
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




