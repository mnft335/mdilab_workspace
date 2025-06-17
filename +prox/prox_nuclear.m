function y = prox_nuclear(x, gamma, lambda)
    import prox.soft_thresholding
    [u, s, v] = svd(x);
    y = u * soft_thresholding(s, gamma * lambda) * v';
end