function visualize_components(config, state)
    
    % Flag the source nodes in the incidence
    source_indices = config.G.Diff > 0;

    % Flag the differences involving the flagged source nodes
    p_flagged = source_indices .* (sqrt(config.G.weights) .* config.G.Diff * state.x{1} - state.x{2});
    q_flagged = source_indices .* state.x{2};

    % Collapse the differences into each node
    p_collapsed = vecnorm(p_flagged, 1);
    q_collapsed = vecnorm(q_flagged, 1);
    size(p_collapsed)
    size(q_collapsed)
    

    figure;
    tiledlayout(1, 2);
    ax(1) = nexttile;
    gsp_plot_signal(config.G, p_collapsed);
    ax(2) = nexttile;
    gsp_plot_signal(config.G, q_collapsed);
    linkaxes(ax(:));

end