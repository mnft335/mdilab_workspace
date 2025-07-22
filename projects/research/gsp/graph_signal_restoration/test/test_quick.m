clear;

experiment_config.generate_weights = @generate_uniform_weights;
experiment_config.masking_rate = 0.5;
experiment_config.sigma = 0.1;

weight_corruption_ratio = 0.0:0.1:1.0;
weight_corruption_sigma = 0.1:0.1:1.0;
random_seed = 0:9;

for k = 1:numel(weight_corruption_ratio)
    for i = 1:numel(weight_corruption_sigma)
        for j = 1:numel(random_seed)
        
            experiment_config.weight_corruption = @(weights, idx) add_normal_noise(weights, idx, weight_corruption_sigma(i));
            experiment_config.weight_corruption_ratio = weight_corruption_ratio(k);
            rng(random_seed(j));

            glr_config = struct();
            shared_config = shared_config_factory(experiment_config);

            glr_result = solve_glr(shared_config, glr_config);
            glr_accuracy(k, i, j) = compute_relative_error(glr_result.x{1}, shared_config.true_signal);
   
            
        end
    end
end

resultant_accuracy = mean(glr_accuracy, 3);

for k = 1:numel(weight_corruption_ratio)

    figure;
    tiledlayout(2, int8(numel(weight_corruption_ratio) / 2));
    hold on

    ax(k) = nexttile;
    plot(weight_corruption_sigma, resultant_accuracy(k, :));

end

linkaxes(ax(:));