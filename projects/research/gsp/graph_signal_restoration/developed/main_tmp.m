clear;

corruption_rate = 0.1:0.1:0.9;
alpha = 0.1:0.1:0.9;

for j = 1:numel(alpha)
for i = 1:numel(corruption_rate)

rng(0);

experiment_config.kernel_sigma = 0.1;
experiment_config.corruption_rate = corruption_rate(i);
experiment_config.masking_rate = 0.5;
experiment_config.sigma = 0.25;

shared_config = shared_config_factory(experiment_config);
% glr_config = struct();
% gtv_config = struct();
proposal_config.alpha = alpha(j);

% glr_solved = solve_glr(shared_config, glr_config);
% gtv_solved = solve_gtv(shared_config, gtv_config);
proposal_solved = solve_proposal(shared_config, proposal_config);

% disp(glr_solved.accuracy(end));
% glr_accuracy(i) = glr_solved.accuracy(end);

disp(proposal_solved.accuracy(end));
proposal_accuracy(i) = proposal_solved.accuracy(end);

end

figure;
% plot(corruption_rate, glr_accuracy);
plot(corruption_rate, proposal_accuracy);

end

% figure;
% subplot(1, 3, 1);
% gsp_plot_signal(shared_config.G, shared_config.true_signal);
% clim([0, 1]);
% colorbar("off");
% colorbar("North");
% title("Ground Truth");

% subplot(1, 3, 2);
% gsp_plot_signal(shared_config.G, shared_config.b);
% clim([0, 1]);
% colorbar("off");
% colorbar("North");
% title("Observation");

% subplot(1, 3, 3);
% gsp_plot_signal(shared_config.G, glr_solved.x{1});
% clim([0, 1]);
% colorbar("off");
% colorbar("North");
% title("Restored by GLR");