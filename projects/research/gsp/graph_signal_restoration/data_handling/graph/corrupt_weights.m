function W = corrupt_weights(W, corruption_method, corruption_ratio)
    if corruption_ratio ~= 0
        [i, j] = select_edges(W, corruption_ratio);
        W = corruption_method(W, i, j);
    end
end