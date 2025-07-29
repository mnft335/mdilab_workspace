function noisy_signal = corrupt_signal(stream, clean_signal, observation_matrix, sigma)

    % Corrupt the clean signal
    noisy_signal = observation_matrix(clean_signal) + sigma * randn(stream, size(clean_signal));

end