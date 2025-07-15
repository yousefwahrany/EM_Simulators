function [result] = calculate_E_2D(p1, p2, x_0, y_0, ko)
        
    if p2(1) == p1(1)
        b = p2(1);
        f = @(y) besselh(0, 2, ko * sqrt((y_0 - y).^2 + (x_0 - b)^2));  
        result = integral(f, p1(2), p2(2));
        
    else
        a = (p2(2) - p1(2))/(p2(1) - p1(1));
        b = p2(2) - a * p2(1);
        f = @(x) besselh(0, 2, ko * sqrt((x_0 - x).^2 + (y_0 - (a * x + b)).^2));  
        result = integral(f, p1(1), p2(1));
    end
end

