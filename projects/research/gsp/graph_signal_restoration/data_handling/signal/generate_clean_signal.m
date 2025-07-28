function signal = generate_clean_signal(stream, graph, num_frequencies)

    % Obtain the frequency indices in ascending order
    [~, idx_ascending_frequency] = sort(graph.e);

    % Combine low-frequency components with random coefficients
    signal = graph.U(:, idx_ascending_frequency(1:num_frequencies)) * rand(stream, num_frequencies, 1);

    % Shift the signal to make the minimum larger than 0
    signal = signal + max(0, max(- signal));

    % Normalize the signal to make the maximum to be 1
    signal = signal ./ max(signal);

end