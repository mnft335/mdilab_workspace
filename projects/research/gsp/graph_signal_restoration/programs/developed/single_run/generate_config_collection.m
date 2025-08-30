function config_collection = generate_config_collection(param, arg)

    % Create all configurations
    config_collection.config_true_graph = factory_config_true_graph(param.true_graph, arg);
    config_collection.config_corrupted_graph = factory_config_corrupted_graph(param.corrupted_graph, arg);
    config_collection.config_true_signal = factory_config_true_signal(param.true_signal, arg);
    config_collection.config_observation_model = factory_config_observation_model(param.observation_model, arg);
    config_collection.config_optimization = factory_config_optimization(param.optimization, arg);

    % Create the configuration name
    config_collection.configuration_name = [config_collection.config_true_graph.configuration_name, ...
                                            config_collection.config_corrupted_graph.configuration_name, ...
                                            config_collection.config_true_signal.configuration_name, ...
                                            config_collection.config_observation_model.configuration_name, ...
                                            config_collection.config_optimization.configuration_name];

end