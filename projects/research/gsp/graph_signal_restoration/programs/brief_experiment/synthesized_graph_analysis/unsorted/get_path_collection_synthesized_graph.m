function path_collection_synthesized_graph = get_path_collection_synthesized_graph()

    % Define a path to the synthesized graph registry
    path_collection_synthesized_graph.path_synthesized_graph_registry = "projects\research\gsp\graph_signal_restoration\programs\brief_experiment\synthesized_graph_analysis\resources\synthesized_graph_registry";
    path_collection_synthesized_graph.path_graph_uniform = fullfile(path_collection_synthesized_graph.path_synthesized_graph_registry, "path_graph_uniform.mat");
    path_collection_synthesized_graph.path_graph_1_spike = fullfile(path_collection_synthesized_graph.path_synthesized_graph_registry, "path_graph_1_spike.mat");
    path_collection_synthesized_graph.path_graph_single_drop = fullfile(path_collection_synthesized_graph.path_synthesized_graph_registry, "path_graph_single_drop.mat");
    path_collection_synthesized_graph.path_graph_11_spikes = fullfile(path_collection_synthesized_graph.path_synthesized_graph_registry, "path_graph_11_spikes.mat");
    path_collection_synthesized_graph.path_graph_11_drops = fullfile(path_collection_synthesized_graph.path_synthesized_graph_registry, "path_graph_11_drops.mat");

end