function object_collection = generate_object_collection(config_collection)

    % Generate all objects
    object_collection.true_graph = load_true_graph(config_collection.config_true_graph);
    object_collection.corrupted_graph = config_collection.config_corrupted_graph.generate_corrupted_graph(object_collection.true_graph);
    object_collection.true_signal = config_collection.config_true_signal.generate_true_signal(object_collection.true_graph);
    object_collection.observation_model = config_collection.config_observation_model.generate_observation_model(object_collection.true_graph);
    object_collection.optimization = config_collection.config_optimization.generate_optimization(object_collection.corrupted_graph, object_collection.true_signal, object_collection.observation_model);

end