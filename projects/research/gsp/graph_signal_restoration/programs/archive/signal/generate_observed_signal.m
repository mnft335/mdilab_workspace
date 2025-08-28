function observed_signal = generate_observed_signal(clean_signal, linear_observation_method, generate_noise)

    % Observation process: linear transformation + additive noise
    observed_signal = linear_observation_method(clean_signal) + generate_noise(size(clean_signal));

end