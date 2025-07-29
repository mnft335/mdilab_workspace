function result = normal(stream, shape, sigma)

    % Sample from the normal distribution
    result = sigma * randn(stream, shape);

end