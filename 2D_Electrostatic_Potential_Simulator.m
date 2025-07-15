clear all
% MATLAB script to calculate the integral based on user input
Vo = 1;
epsilon = 8.85418782*10^(-12);
% Ask the user for input values
x1 = -0.5; %input('Enter the start point of the sheet: ');
x2 = 0.5; %input('Enter the end point of the sheet: ');
N = 21; %input('Enter the number of points to be calculated: ');
i = 0;

    
i = i + 1;
X = linspace(x1, x2, N+1);
X_mid = (X(1:end-1) + X(2:end)) / 2;

% Initialize S matrix
S = zeros(N, N);

% Fill the S matrix
for m = 1:N
    for n = 2:N+1
        S(m, n - 1) = -1/(2*pi*epsilon) * ln_integral(X(n - 1), X(n), X_mid(m));
    end
end

hold on
q_n = inv(S) * ones(N, 1);


% %title('Professional Curve Plot', 'FontSize', 14, 'FontWeight', 'bold');
% y_0 = 0;
% No = 300;
% x_0 = linspace(-0.5, 0.5, No);
% V=0;
% for k = 1:1
%     for j = 1:No
%         for i = 1:N
%             V = V + q_n(i)* -1/(2*pi*epsilon) * calculate_V(X(i), X(i+1), x_0(j), y_0(k));
%         end
%         V_space(k, j) = V;
%         V = 0;
%     end
% end
% 
% plot(x_0, V_space - 1, 'b-', 'LineWidth', 1); % Blue solid line with 2px width
% grid on;
% grid minor;
% 
% 
% % Add labels and title
% xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
% ylabel('V - Vo', 'FontSize', 12, 'FontWeight', 'bold');
% ylim([-4 4]*0.001)



%calculate V every where
No = 1000;
x_0 = linspace(-3, 3, No);
y_0 = linspace(-3, 3, No);
V = 0;
k = 1;

for k = 1:No
    for j = 1:No
        for i = 1:N
            V = V + q_n(i)* -1/(2*pi*epsilon) * calculate_V(X(i), X(i+1), x_0(j), y_0(k));
        end
        V_space(k, j) = V;
        V = 0;
    end
end

imagesc(x_0, y_0, V_space);
colorbar; % Add color bar to show scale
colormap(hot); % Change colormap (options: jet, hot, cool, parula, etc.)
set(gca, 'YDir', 'normal');
caxis([-1.5 1]);
% Add title and labels
title('E everywhere');
ylim([-3 3])
xlim([-3 3])
xlabel('X');
ylabel('Y');
hold on
[dz_dx, dz_dy] = gradient(V_space, x_0(2) - x_0(1), y_0(2) - y_0(1));
dz_dx = -1*dz_dx;
dz_dy = -1*dz_dy;
% quiver(x_0, y_0, dz_dx, dz_dy, 1.5, 'b', 'LineWidth', 1);

contour(x_0, y_0, V_space, [0 0], 'LineWidth', 2, 'LineColor', 'black');


