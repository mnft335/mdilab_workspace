function result = sample_uniform(stream, shape, lower_bound, upper_bound)

    % Sample from the uniform distribution
    result = rand(stream, shape);

    % Scale and shift the sampled values to the specified range
    result = lower_bound + (upper_bound - lower_bound) * result;
    
end