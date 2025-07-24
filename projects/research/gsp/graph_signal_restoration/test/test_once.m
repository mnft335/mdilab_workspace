clear;

experiment_config.generate_weights = @(W) generate_truncated_normal_weights(W, 1);
experiment_config.num_sampling = 15;
experiment_config.masking_rate = 0.5;
experiment_config.signal_noise_sigma = 0.1;
experiment_config.weight_corruption_ratio = 1;

weight_corruption_sigma = 1.0;
experiment_config.weight_corruption = @(weights, idx) add_normal_noise(weights, idx, weight_corruption_sigma);

rng(0);

glr_config = struct();
shared_config = shared_config_factory(experiment_config);

glr_result = solve_glr(shared_config, glr_config);

plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, glr_result.x{1});