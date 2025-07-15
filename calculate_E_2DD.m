function [result] = calculate_E(x1, x2, x_0, y_0, ko)

    f = @(x) besselh(0, 2, ko * sqrt((x_0 - x).^2 + y_0^2));  % Define the function
    result = integral(f, x1, x2);
end

