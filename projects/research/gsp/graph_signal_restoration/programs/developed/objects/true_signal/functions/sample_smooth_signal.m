function smooth_signal = sample_smooth_signal(graph, generate_smooth_sampling_coefficients)

    % Reorder the eigenvector matrix so that the corresponding eigenvalues are in ascending order
    [~, idx_ascending_frequencies] = sort(graph.e);
    ascending_eigenvectors = graph.U(:, idx_ascending_frequencies);

    % Combine low-frequency components with random coefficients
    smooth_sampling_coefficients = generate_smooth_sampling_coefficients(ascending_eigenvectors);
    smooth_signal = ascending_eigenvectors * smooth_sampling_coefficients;

end