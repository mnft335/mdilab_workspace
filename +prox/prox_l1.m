function y = prox_l1(x, gamma, lambda)
    import prox.soft_thresholding
    y = soft_thresholding(x, gamma * lambda);
end