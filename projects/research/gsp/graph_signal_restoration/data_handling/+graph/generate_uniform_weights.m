function weights_forward = generate_uniform_weights(stream, num_forward_edges)

    % Sample weights on the forward edges from the uniform distribution
    weights_forward = rand(stream, num_forward_edges, 1);

end