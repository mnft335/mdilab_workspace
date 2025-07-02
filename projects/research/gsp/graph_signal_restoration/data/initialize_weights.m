function weights = initialize_weights(weights, signal, sigma)
    adjacency = weights > 0;
    squared_difference = (signal - signal.').^2;
    weights = exp(- squared_difference / (2 * sigma^2));
    weights = weights .* adjacency;
end