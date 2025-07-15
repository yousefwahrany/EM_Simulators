function [result] = Hankel_integral_2D(p1 ,p2 , p_mid, ko)
    
    % Define the function
        
    if p2(1) == p1(1)
        b = p2(1);
        f = @(y) besselh(0, 2, ko * sqrt((p_mid(2) - y).^2 + (p_mid(1) - b)^2));  
        result = integral(f, p1(2), p2(2));
        
    else
        a = (p2(2) - p1(2))/(p2(1) - p1(1));
        b = p2(2) - a * p2(1);
        f = @(x) besselh(0, 2, ko * sqrt((p_mid(1) - x).^2 + (p_mid(2) - (a * x + b)).^2));  
        result = integral(f, p1(1), p2(1));
    end
end
