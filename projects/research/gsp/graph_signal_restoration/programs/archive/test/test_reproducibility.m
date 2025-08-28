clear;
gsp_start();
rng(0);

% Load the graph adjacency
load(path_search("Rome"));
adjacency = W;

master_seed = randi(intmax("int32"), 10, "int32");
weight_generation_method = @(idx_forward_edges) generate_normal_weights(idx_forward_edges, 1, master_seed);

concrete_config.generate_weights = @() generate_weights(adjacency, weight_generation_method);
concrete_config.generate_clean_signal = @(graph) generate_clean_signal(graph, num_frequencies, master_seed);
concrete_config.corrupt_weights = @(weights) corrupt_weights(weights, corruption_ratio, corruption_method, master_seed);
concrete_config.generate_signal_mask = 