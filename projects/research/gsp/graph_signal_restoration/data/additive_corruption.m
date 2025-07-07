function W = additive_corruption(W, i, j, sigma)
    noise = sigma * abs(randn(numel(i), 1));
    W(sub2ind(size(W), i, j)) = W(sub2ind(size(W), i, j)) + noise;
    W(sub2ind(size(W), j, i)) = W(sub2ind(size(W), j, i)) + noise;
end