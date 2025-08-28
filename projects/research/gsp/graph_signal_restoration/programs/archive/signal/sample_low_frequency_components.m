function raw_signal = sample_low_frequency_components(graph, generate_signal_sampling_coefficients)
    
    % Obtain the frequency indices in ascending order
    [~, idx_ascending_frequencies] = sort(graph.e);

    % Reorder the eigenvector matrix according to the frequencies in ascending order
    ascending_eigenvectors = graph.U(idx_ascending_frequencies);

    % Combine low-frequency components with random coefficients
    signal_sampling_coefficients = generate_signal_sampling_coefficients(ascending_eigenvectors);
    raw_signal = ascending_eigenvectors * signal_sampling_coefficients;

end