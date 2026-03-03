function result = sample_truncated_gaussian(stream, normal_distribution, lower_bounds, upper_bounds)

    % Normal distributions truncated below at the input
    truncated_normal_distribution = arrayfun(@(z1, z2) truncate(normal_distribution, z1, z2), lower_bounds, upper_bounds);

    % Sample from the truncated normal distributions, using the inverse transform sampling
    result = arrayfun(@icdf, truncated_normal_distribution, rand(stream, size(lower_bounds)));
    
end