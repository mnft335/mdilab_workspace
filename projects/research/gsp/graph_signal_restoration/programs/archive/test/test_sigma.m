clear;

sigma = 0.1:0.1:1.0;

for i = 1:numel(sigma)
    rng(0);

    experiment_config.kernel_variance = 0.07;
    experiment_config.corruption_rate = 0.0;
    experiment_config.masking_rate = 0.5;
    experiment_config.sigma = sigma(i);

    glr_config = struct();
    shared_config = shared_config_factory(experiment_config);

    glr_solved = solve_glr(shared_config, glr_config);

    accuracy_log(i) = glr_solved.accuracy(end);
end

figure;
tiledlayout(1, 1, "TileSpacing", "tight");
nexttile
plot(sigma, accuracy_log);