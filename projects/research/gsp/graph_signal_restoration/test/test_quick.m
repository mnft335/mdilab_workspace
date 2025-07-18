clear;

experiment_config.generate_weights = @generate_uniform_weights;
experiment_config.weight_corruption_ratio = 1;
experiment_config.masking_rate = 0.5;
experiment_config.sigma = 0.1;

corruption_sigma = 0.1:0.1:1.0;
random_seed = 0:9;

for i = 1:numel(corruption_sigma)
    for j = 1:numel(random_seed)
    
        experiment_config.weight_corruption = @(weights, idx) add_truncated_normal_noise(weights, idx, corruption_sigma(i));
        rng(random_seed(j));

        glr_config = struct();
        shared_config = shared_config_factory(experiment_config);

        glr_result = solve_glr(shared_config, glr_config);
        glr_accuracy(j, i) = compute_relative_error(glr_result.x{1}, shared_config.true_signal);
    
    end
end

figure;
tiledlayout(2, int8(numel(corruption_sigma) / 2));
hold on

nexttile;
plot(corruption_sigma, mean(glr_accuracy, 1));