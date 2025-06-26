    function W = multiplicative_corruption(W, i, j)
        factor = 1 + abs(randn(numel(i), 1));

        W(sub2ind(size(W), i, j)) = W(sub2ind(size(W), i, j)) .* factor;
        W(sub2ind(size(W), j, i)) = W(sub2ind(size(W), j, i)) .* factor;
    end