    function result = corruption(G, i, j)
        inflate_range = [5, 10];
        deflate_range = [0.1, 0.2];

        W = G.W;
        for k = 1:length(i)
            if rand > 0.5
                factor = rand() * diff(inflate_range) + inflate_range(1);
            else
                factor = rand() * diff(deflate_range) + deflate_range(1);
            end

            W(i(k), j(k)) = W(i(k), j(k)) * factor;
            W(j(k), i(k)) = W(j(k), i(k)) * factor;
        end

        result = gsp_update_weights(G, W);
    end