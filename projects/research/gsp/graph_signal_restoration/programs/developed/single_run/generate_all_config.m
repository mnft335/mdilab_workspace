function all_config = generate_all_config(param)

    % Get all configurations
    all_config.config_true_graph = factory_config_true_graph(param.true_graph, []);
    all_config.config_corrupted_graph = factory_config_corrupted_graph(param.corrupted_graph, []);
    all_config.config_true_signal = factory_config_true_signal(param.true_signal, []);
    all_config.config_observation_model = factory_config_observation_model(param.observation_model, []);
    all_config.config_optimization = factory_config_optimization(param.optimization, []);

    % Create the configuration name
    all_config.configuration_name = [all_config.config_true_graph.configuration_name, ...
                                     all_config.config_corrupted_graph.configuration_name, ...
                                     all_config.config_true_signal.configuration_name, ...
                                     all_config.config_observation_model.configuration_name, ...
                                     all_config.config_optimization.configuration_name];

end