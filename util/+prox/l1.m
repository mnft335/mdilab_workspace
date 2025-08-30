function result = l1(x, gamma, lambda)
    result = soft_thresholding(x, gamma * lambda);
end