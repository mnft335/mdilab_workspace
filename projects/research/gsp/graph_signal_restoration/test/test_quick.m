clear;

gsp_start();

% Set the graph adjacency
load(path_search("Rome"));
experiment_config.adjacency = W;

% Parameters to iterate over
generate_weights_sigma = 0.1:0.1:1.0;
num_sampling = 60:60:300;
weight_corruption_ratio = 0.0:0.2:1.0;
weight_corruption_sigma = 0.5:0.5:2.0;
masking_rate = 0.2:0.2:0.8;
signal_noise_sigma = 

random_seed = 0:9;



for k = 1:numel(weight_corruption_ratio)
    for i = 1:numel(weight_corruption_sigma)
        for j = 1:numel(random_seed)
            experiment_config.generate_weights = @(W) generate_normal_weights(W, generate_weights_sigma);
            experiment_config.num_sampling = num_sampling();
            experiment_config.weight_corruption_ratio = weight_corruption_ratio(k);
            experiment_config.weight_corruption = @(weights, idx) add_normal_noise(weights, idx, weight_corruption_sigma(i));
            experiment_config.masking_rate = 0.5;
            experiment_config.signal_noise_sigma = 0.1;
            rng(random_seed(j));

            glr_config = struct();
            shared_config = shared_config_factory(experiment_config);

            glr_result = solve_glr(shared_config, glr_config);
            glr_accuracy(k, i, j) = compute_relative_error(glr_result.x{1}, shared_config.true_signal);
   
        end
    end
end

resultant_accuracy = mean(glr_accuracy, 3);