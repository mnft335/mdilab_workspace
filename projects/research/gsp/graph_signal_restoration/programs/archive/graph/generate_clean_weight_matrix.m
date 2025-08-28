function clean_weight_matrix = generate_clean_weight_matrix(adjacency, generate_forward_weights)

    % Find the indices of the forward edges (edges in the upper triangular part)
    num_forward_edges = numel(find(triu(adjacency, 1) ~= 0));

    % Sample weights on the forward edges from the Gaussian distribution
    size = [num_forward_edges, 1];
    forward_weights = generate_forward_weights(size);

    % Create complete weights from the forward ones
    clean_weight_matrix = create_weight_matrix(adjacency, forward_weights);

end