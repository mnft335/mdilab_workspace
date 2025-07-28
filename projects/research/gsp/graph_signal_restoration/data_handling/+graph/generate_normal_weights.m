function weights_forward = generate_normal_weights(stream, idx_forward_edges, sigma)

    % Sample weights on the forward edges from the Gaussian distribution
    weights_forward = sigma * randn(stream, numel(idx_forward_edges), 1);

end
