function weights = initialize_weights(weights, signal, variance)
    num_edges = numel(find(triu(weights, 1)));
    adjacency = weights > 0;
    squared_difference = (signal - signal.').^2;
    weights = exp(- squared_difference / (2 * variance));
    weights = weights .* num_edges / sum(weights, 'all');
    weights = weights .* adjacency;
end