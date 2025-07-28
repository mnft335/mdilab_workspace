function y = soft_thresholding(x, gamma)
    y = sign(x) .* max(abs(x) - gamma, 0);
end