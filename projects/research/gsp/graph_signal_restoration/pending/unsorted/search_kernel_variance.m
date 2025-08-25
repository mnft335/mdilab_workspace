clear;

kernel_variance = 0.001:0.001:0.01;
random_seed = 0:9;

for i = 1:numel(kernel_variance)
for j = 1:numel(random_seed)

    rng(j);

    experiment_config.kernel_variance = kernel_variance(i);
    experiment_config.corruption_method = @(W, k, l) additive_corruption(W, k, l, corruption_sigma(j));
    experiment_config.corruption_rate = 0.0;
    experiment_config.masking_rate = 0.5;
    experiment_config.sigma = 0.0;

    glr_config = struct();
    gtv_config = struct();
    proposal_config.alpha = 0.5;
    shared_config = shared_config_factory(experiment_config);

    glr_solved = solve_glr(shared_config, glr_config);
    gtv_solved = solve_gtv(shared_config, gtv_config);
    proposal_solved = solve_proposal(shared_config, proposal_config);

    accuracy_glr(i, j) = glr_solved.accuracy(end);
    accuracy_gtv(i, j) = gtv_solved.accuracy(end);
    accuracy_proposal(i, j) = proposal_solved.accuracy(end);

end
end

[minimum, argmin] = min(mean(accuracy_glr, 2));
disp("The minimum " + num2str(minimum) + " is attained at kernel_variance = " + num2str(kernel_variance(argmin)));

figure;
tiledlayout(1, 3);
ax(1) = nexttile;
plot(kernel_variance, mean(accuracy_glr, 2));
title("GLR");
ax(2) = nexttile;
plot(kernel_variance, mean(accuracy_gtv, 2));
title("GTV");
ax(3) = nexttile;
plot(kernel_variance, mean(accuracy_proposal, 2));
title("Proposal");

linkaxes(ax(:));