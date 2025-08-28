function all_data = generate_all_data(all_config, path_true_graph_registry)

    % Get all data
    all_data.true_graph = load_or_generate_true_graph(all_config.config_true_graph, path_true_graph_registry);
    all_data.corrupted_graph = all_config.config_corrupted_graph.generate_corrupted_graph(all_data.true_graph);
    all_data.true_signal = all_config.config_true_signal.generate_true_signal(all_data.true_graph);
    all_data.observation_model = all_config.config_observation_model.generate_observation_model(all_data.true_graph);
    all_data.optimization = all_config.config_optimization.generate_optimization(all_data.corrupted_graph, all_data.true_signal, all_data.observation_model);

end