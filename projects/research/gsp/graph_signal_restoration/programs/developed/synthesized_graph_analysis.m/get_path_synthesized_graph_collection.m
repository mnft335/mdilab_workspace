function path_synthesized_graph_collection = get_path_synthesized_graph_collection()

    % Define a path to the synthesized graph registry
    path_synthesized_graph_registry = "projects\research\gsp\graph_signal_restoration\programs\developed\synthesized_graph_registry";

    path_synthesized_graph_collection.path_graph_uniform = fullfile(path_synthesized_graph_registry, "path_graph_uniform.mat");
    path_synthesized_graph_collection.path_graph_1_spike = fullfile(path_synthesized_graph_registry, "path_graph_1_spike.mat");
    path_synthesized_graph_collection.path_graph_1_drop = fullfile(path_synthesized_graph_registry, "path_graph_1_drop.mat");
    path_synthesized_graph_collection.path_graph_11_spikes = fullfile(path_synthesized_graph_registry, "path_graph_11_spikes.mat");
    path_synthesized_graph_collection.path_graph_11_drops = fullfile(path_synthesized_graph_registry, "path_graph_11_drops.mat");

end