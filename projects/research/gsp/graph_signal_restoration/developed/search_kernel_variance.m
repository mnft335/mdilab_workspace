clear;

kernel_variance = 0.01:0.01:0.25;
% kernel_variance = 0.02;

for i = 1:numel(kernel_variance)
    rng(0);

    experiment_config.kernel_variance = kernel_variance(i);
    experiment_config.corruption_rate = 0.0;
    experiment_config.masking_rate = 0.5;
    experiment_config.sigma = 0.0;

    glr_config = struct();
    shared_config = shared_config_factory(experiment_config);
    glr_solved = solve_glr(shared_config, glr_config);

    accuracy_log(i) = glr_solved.accuracy(end);
end

% plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, glr_solved.x{1});

[minimum, argmin] = min(accuracy_log);
disp("The minimum " + num2str(minimum) + " is attained at kernel_variance = " + num2str(kernel_variance(argmin)));

figure;
plot(kernel_variance, accuracy_log);