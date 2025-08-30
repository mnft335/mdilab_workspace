function y = soft_thresholding(x, gamma)

    % Apply soft thresholding to the input
    y = sign(x) .* max(abs(x) - gamma, 0);
    
end