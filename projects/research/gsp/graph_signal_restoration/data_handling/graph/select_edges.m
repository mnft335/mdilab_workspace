function [i, j] = select_edges(W, selection_ratio)
    [i, j] = find(triu(W, 1));
    selected_idx = randperm(numel(i), round(numel(i) * selection_ratio));
    i = i(selected_idx);
    j = j(selected_idx);
end