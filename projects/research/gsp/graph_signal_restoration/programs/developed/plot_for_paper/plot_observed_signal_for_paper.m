function graph_plot = plot_observed_signal_for_paper(result)

    % Get the graph object
    graph_gsp_toolbox = result.object_collection.true_graph;

    % Get the observed signal
    observed_signal = result.object_collection.optimization.config_solver.observed_signal;

    % Get the observation operator
    observation_operator = result.object_collection.observation_model.observation_operator;

    % Get the indices of masked nodes
    indices_masked_nodes = find(observation_operator(ones(size(observed_signal))) == 0);

    % Create a color matrix for the masked nodes
    color_map_masked_nodes = zeros(numel(indices_masked_nodes), 3);

    % Configure node settings
    config_node.values = observed_signal;
    config_node.color_map = jet(256);
    config_node.color_map = map_vector_to_color(config_node.values, [0, 1], config_node.color_map);
    config_node.color_map(indices_masked_nodes, :) = color_map_masked_nodes;

    % Configure edge settings
    weight_noise = extract_weight_noise(result);
    config_edge.values = double(abs(weight_noise) > 1e-12);
    color_map = gray(256);
    config_edge.color_map = flipud(color_map(1:200, :));

    % Plot the observed signal on the graph, with the corrupted edges highlighted
    graph_plot = plot_values_on_graph_for_paper_tmp(graph_gsp_toolbox, config_node, config_edge);

end