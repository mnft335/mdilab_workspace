function noise = generate_truncated_normal_noise(stream, forward_weights, sigma)
    
    % Function that creates normal distributions truncated at the input
    truncated_normal_distribution = @(z) truncate(makedist("Normal", "mu", 0, "sigma", sigma), - z, Inf);

    % Sample noises on the forward_weights from normal distributions truncated at each weight, using the inverse transform sampling
    noise = arrayfun(@(z) icdf(truncated_normal_distribution(z), rand(stream)), forward_weights);

end