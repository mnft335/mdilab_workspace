function weighted_adjacency = generate_weighted_adjacency(adjacency, generate_forward_weights)

    % Find the indices of the forward edges (edges in the upper triangular part)
    num_forward_edges = triu(adjacency, 1) ~= 0;

    % Sample weights on the forward edges from the Gaussian distribution
    forward_weights = generate_forward_weights(num_forward_edges);

    % Create complete weights from the forward ones
    weighted_adjacency = create_weight_matrix(forward_weights, adjacency);

end