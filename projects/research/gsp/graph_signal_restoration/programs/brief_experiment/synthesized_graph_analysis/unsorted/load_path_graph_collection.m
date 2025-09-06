function path_graph_collection = load_path_graph_collection()

    % Get all paths to synthesized path graphs
    path_collection_synthesized_graph = get_path_collection_synthesized_graph();

    % Load all synthesized path graphs
    path_graph_collection.path_graph_uniform = load_file(path_collection_synthesized_graph.path_graph_uniform);
    path_graph_collection.path_graph_1_spike = load_file(path_collection_synthesized_graph.path_graph_1_spike);
    path_graph_collection.path_graph_single_drop = load_file(path_collection_synthesized_graph.path_graph_single_drop);
    path_graph_collection.path_graph_11_spikes = load_file(path_collection_synthesized_graph.path_graph_11_spikes);
    path_graph_collection.path_graph_11_drops = load_file(path_collection_synthesized_graph.path_graph_11_drops);

end