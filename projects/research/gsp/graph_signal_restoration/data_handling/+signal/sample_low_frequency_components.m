function raw_signal = sample_low_frequency_components(stream, graph, num_sampled_frequencies)
    
    % Obtain the frequency indices in ascending order
    [~, idx_ascending_frequency] = sort(graph.e);

    % Combine low-frequency components with random coefficients
    raw_signal = graph.U(:, idx_ascending_frequency(1:num_sampled_frequencies)) * rand(stream, num_sampled_frequencies, 1);

end