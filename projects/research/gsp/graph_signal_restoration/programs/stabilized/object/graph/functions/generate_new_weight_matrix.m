function new_weight_matrix = generate_new_weight_matrix(weight_matrix, generate_new_forward_weights)

    % Generate a new weight matrix from a given weight matrix and forward weight generation method
    forward_weights = weight_matrix(triu(weight_matrix, 1) > 0);
    new_forward_weights = generate_new_forward_weights(forward_weights);

    % Create a new weight matrix
    adjacency_matrix = double(weight_matrix > 0);
    new_weight_matrix = create_weight_matrix(adjacency_matrix, new_forward_weights);

end