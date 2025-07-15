function [result] = Hankel_integral(x1 ,x2 , X_mid, ko)
    
    f = @(x) besselh(0, 2, ko * abs(X_mid - x));  % Define the function
    result = integral(f, x1, x2);
%     
%     integral = (x2 - X_mid) * log(abs(X_mid - x2)) - ...
%          (x1 - X_mid) * log(abs(X_mid - x1)) - ...
%          x2 + x1;
end
