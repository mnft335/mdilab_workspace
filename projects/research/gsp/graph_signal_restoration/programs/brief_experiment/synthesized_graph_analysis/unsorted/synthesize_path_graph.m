function synthesize_path_graph()

    % Get all paths to synthesized graphs
    path_collection_synthesized_graph = get_path_collection_synthesized_graph();

    % Specify the number of nodes
    num_nodes = 32;

    % Get the coordinates of a path graph
    path_graph = gsp_path(num_nodes);

    % Recreate the path graph to standardize graph objects
    path_graph_uniform = create_graph(path_graph.W);
    save_file(path_graph_uniform, path_collection_synthesized_graph.path_graph_uniform);

    % Create a weighted path graph with 1 spike
    generate_new_forward_weights = @(forward_weights) assign_partial_elements(forward_weights, 16, 10 * forward_weights(16));
    path_graph_1_spike = generate_new_graph(path_graph_uniform.W, generate_new_forward_weights);
    save_file(path_graph_1_spike, path_collection_synthesized_graph.path_graph_1_spike);

    % Create a weighted path graph with 1 drop
    generate_new_forward_weights = @(forward_weights) assign_partial_elements(forward_weights, 16, 0.1 * forward_weights(16));
    path_graph_single_drop = generate_new_graph(path_graph_uniform.W, generate_new_forward_weights);
    save_file(path_graph_single_drop, path_collection_synthesized_graph.path_graph_single_drop);

    % Create a weighted path graph with 11 spikes
    generate_new_forward_weights = @(forward_weights) assign_partial_elements(forward_weights, 1:3:31, 10 * forward_weights(1:3:31));
    path_graph_11_spikes = generate_new_graph(path_graph_uniform.W, generate_new_forward_weights);
    save_file(path_graph_11_spikes, path_collection_synthesized_graph.path_graph_11_spikes);

    % Create a weighted path graph with 11 drops
    generate_new_forward_weights = @(forward_weights) assign_partial_elements(forward_weights, 1:3:31, 0.1 * forward_weights(1:3:31));
    path_graph_11_drops = generate_new_graph(path_graph_uniform.W, generate_new_forward_weights);
    save_file(path_graph_11_drops, path_collection_synthesized_graph.path_graph_11_drops);

end