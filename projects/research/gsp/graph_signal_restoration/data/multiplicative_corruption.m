    function result = multiplicative_corruption(W, i, j)
        inflate_range = [5, 10];
        deflate_range = [0.1, 0.2];

        for k = 1:length(i)
            if rand() > 0.5
                factor = diff(inflate_range) + inflate_range(1);
            else
                factor = diff(inflate_range) + inflate_range(1);
            end

            W(i(k), j(k)) = W(i(k), j(k)) * factor;
            W(j(k), i(k)) = W(j(k), i(k)) * factor;
        end

        result = W;
    end