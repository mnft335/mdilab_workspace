function result = truncated_normal(stream, lower_bounds, sigma)

    % Normal distribution object
    normal_distribution = makedist("Normal", "mu", 0, "sigma", sigma);

    % Normal distributions truncated below at the input
    truncated_normal_distribution = arrayfun(@(z) truncate(normal_distribution, z), lower_bounds);

    % Sample from the truncated normal distributions, usign the inverse transform sampling
    result = arrayfun(@icdf, truncated_normal_distribution, rand(stream, size(lower_bounds)));
    
end