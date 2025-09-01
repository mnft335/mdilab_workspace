function weight_matrix = create_weight_matrix(adjacency_matrix, forward_weights)

    % Shift the forward weights to make them positive (larger than eps)
    forward_weights = forward_weights + max(0, max(- forward_weights + eps));

    % Normalize the forward weights to make the mean to 1
    forward_weights = forward_weights / mean(forward_weights);

    % Set the forward weights to a weight matrix
    weight_matrix = assign_partial_elements(triu(adjacency_matrix, 1), triu(adjacency_matrix, 1) ~= 0, forward_weights);

    % Set the backward weights symmetrically
    weight_matrix = weight_matrix + weight_matrix.';

    % Check if the weight matrix is valid
    check_weight_matrix(weight_matrix);

end