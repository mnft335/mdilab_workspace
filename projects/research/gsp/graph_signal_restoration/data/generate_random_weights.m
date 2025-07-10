function weights = generate_random_weights(weights)

    num_edges = numel(find(triu(weights, 1)));
    adjacency = weights > 0;
    weights = randn(size(weights));
    weights = abs(weights + weights.');
    weights = weights .* adjacency;
    weights = weights .* num_edges ./ sum(weights, 'all');

end