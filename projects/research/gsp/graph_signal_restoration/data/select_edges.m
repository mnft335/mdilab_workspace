function [i, j] = select_edges(G, selection_ratio)
    [i, j] = find(triu(G.W, 1));
    selected_idx = randperm(length(i), round(numel(i) * selection_ratio));
    i = i(selected_idx);
    j = j(selected_idx);
end