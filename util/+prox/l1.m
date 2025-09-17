function result = l1(x, gamma, lambda)

    % Apply soft thresholding
    result = soft_thresholding(x, gamma * lambda);

end