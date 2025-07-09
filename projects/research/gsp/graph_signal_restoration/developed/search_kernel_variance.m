clear;

kernel_variance = 0.01:0.01:0.1;
% random_seed = 0:9;
random_seed = 0;
for i = 1:numel(kernel_variance)
for j = 1:numel(random_seed)

    rng(j);

    experiment_config.kernel_variance = kernel_variance(i);
    experiment_config.corruption_method = @(W, k, l) additive_corruption(W, k, l, corruption_sigma(j));
    % experiment_config.corruption_method = [];
    experiment_config.corruption_rate = 0.0;
    experiment_config.masking_rate = 0.3;
    experiment_config.sigma = 0.1;

    glr_config = struct();
    gtv_config = struct();
    proposal_config.alpha = 0.5;
    shared_config = shared_config_factory(experiment_config);

    glr_solved = solve_glr(shared_config, glr_config);
    % gtv_solved = solve_gtv(shared_config, gtv_config);
    % proposal_solved = solve_proposal(shared_config, proposal_config);

    accuracy_glr(i) = glr_solved.accuracy(end);
    % accuracy_gtv(i) = gtv_solved.accuracy(end);
    % accuracy_proposal(i) = proposal_solved.accuracy(end);

end
end

[minimum, argmin] = min(accuracy_glr);
disp("The minimum " + num2str(minimum) + " is attained at kernel_variance = " + num2str(kernel_variance(argmin)));

figure;
tiledlayout(1, 3);
ax(1) = nexttile;
plot(kernel_variance, accuracy_glr);
title("GLR");
% ax(2) = nexttile;
% plot(kernel_variance, accuracy_gtv);
% title("GTV");
% ax(3) = nexttile;
% plot(kernel_variance, accuracy_proposal);
% title("Proposal");

linkaxes(ax(:));