    function W = multiplicative_corruption(W, i, j)
        sigma = 0.25;
        mu = - 0.5 * sigma^2;
        factor = exp(mu + sigma * randn(numel(i), 1));
        W(sub2ind(size(W), i, j)) = W(sub2ind(size(W), i, j)) .* factor;
        W(sub2ind(size(W), j, i)) = W(sub2ind(size(W), j, i)) .* factor;
    end