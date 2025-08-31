function new_graph = generate_new_graph(weight_matrix, generate_new_forward_weights)

    % Generate a new graph from a given weight matrix and forward weight generation method
    new_weight_matrix = generate_new_weight_matrix(weight_matrix, generate_new_forward_weights);
    new_graph = create_graph(new_weight_matrix);

end