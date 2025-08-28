clear;

corruption_rate = 0.1:0.1:0.9;
for j = 0:9
accuracy_log(1) = 0;
for i = 1:numel(corruption_rate)
    rng(j);

    experiment_config.kernel_variance = 0.07;
    experiment_config.corruption_rate = corruption_rate(i);
    experiment_config.masking_rate = 0.5;
    experiment_config.sigma = 0.05;

    glr_config = struct();
    shared_config = shared_config_factory(experiment_config);

    glr_solved = solve_glr(shared_config, glr_config);

    accuracy_log(i) = accuracy_log(i) + glr_solved.accuracy(end) / numel(corruption_rate);
end

figure;
tiledlayout(1, 1, "TileSpacing", "tight");
nexttile
plot(corruption_rate, accuracy_log);

end