function weight_matrix = create_weight_matrix(adjacency_matrix, forward_weights)

    % Shift the forward weights to make them nonnegative
    forward_weights = forward_weights + max(0, max(- forward_weights));

    % Normalize the forward weights to mean 1
    forward_weights = forward_weights / mean(forward_weights);

    % Shift the forward weights less than "eps" by "eps"
    forward_weights = forward_weights + max(0, max(- forward_weights + eps));

    % Set the forward weights to a weight matrix
    weight_matrix = assign_partial_elements(tril(adjacency_matrix), tril(adjacency_matrix) > 0, forward_weights);

    % Set the backward weights symmetrically
    weight_matrix = weight_matrix + weight_matrix.';

    % Check if the weight matrix is valid
    check_weight_matrix(weight_matrix);

end