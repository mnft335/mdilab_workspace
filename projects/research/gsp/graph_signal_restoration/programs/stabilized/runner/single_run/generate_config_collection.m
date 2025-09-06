function config_collection = generate_config_collection(param_collection, arg)

    % Create all configurations
    config_collection.config_true_graph = factory_config_true_graph(param_collection.true_graph, arg);
    config_collection.config_corrupted_graph = factory_config_corrupted_graph(param_collection.corrupted_graph, arg);
    config_collection.config_true_signal = factory_config_true_signal(param_collection.true_signal, arg);
    config_collection.config_observation_model = factory_config_observation_model(param_collection.observation_model, arg);
    config_collection.config_optimization = factory_config_optimization(param_collection.optimization, arg);

    % Create the configuration name
    config_collection.configuration_name = [config_collection.config_true_graph.configuration_name, ...
                                            config_collection.config_corrupted_graph.configuration_name, ...
                                            config_collection.config_true_signal.configuration_name, ...
                                            config_collection.config_observation_model.configuration_name, ...
                                            config_collection.config_optimization.configuration_name];

end