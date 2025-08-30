function result = nuclear(x, gamma, lambda)
    [u, s, v] = svd(x);
    result = u * soft_thresholding(s, gamma * lambda) * v';
end