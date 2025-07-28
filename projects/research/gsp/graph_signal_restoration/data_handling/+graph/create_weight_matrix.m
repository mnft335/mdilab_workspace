function weight_matrix = create_weight_matrix(forward_weights, adjacency)

    % Shift the weights to make them positive (larger than eps)
    forward_weights = forward_weights + max(0, max(- forward_weights + eps));

    % Normalize to make the mean of all weights to 1
    forward_weights = forward_weights / mean(forward_weights);

    % Set the forward weights to a weight matrix
    weight_matrix = zeros(size(adjacency));
    weight_matrix(triu(adjacency, 1) ~= 0) = forward_weights;

    % Set the backward weights symmetrically
    weight_matrix = weight_matrix + weight_matrix.';

    % Check if the weights are theoretically valid
    check_weights(weights);

end