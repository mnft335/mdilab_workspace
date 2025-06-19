function result = corrupt_graph(G, corruption, ratio)
    if ratio == 0
        result = G;
        return;
    else
        [i, j] = select_edges(G, ratio);
        result = corruption(G, i, j);
end