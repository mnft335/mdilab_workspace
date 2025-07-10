clear;

corruption_rate = 0.1:0.1:1.0;
random_seed = 0:9;
corruption_sigma = 0.1:0.1:1.0;

for h = 1:numel(corruption_rate)
for i = 1:numel(random_seed)
for j = 1:numel(corruption_sigma)
    rng(i);

    experiment_config.kernel_variance = 0.009;
    experiment_config.corruption_method = @(W, k, l) additive_corruption(W, k, l, corruption_sigma(j));
    experiment_config.corruption_rate = corruption_rate(h);
    experiment_config.masking_rate = 0.5;
    experiment_config.sigma = 0.3;

    glr_config = struct();
    gtv_config = struct();
    proposal_config.alpha = 0.5;
    shared_config = shared_config_factory(experiment_config);

    glr_solved = solve_glr(shared_config, glr_config);
    gtv_solved = solve_gtv(shared_config, gtv_config);
    proposal_solved = solve_proposal(shared_config, proposal_config);

    glr_accuracy(i, j) = glr_solved.accuracy(end);
    gtv_accuracy(i, j) = gtv_solved.accuracy(end);
    proposal_accuracy(i, j) = proposal_solved.accuracy(end);
end
end

figure;
tiledlayout(2, int8((numel(random_seed) + 2) / 2));

for i = 1:numel(random_seed)
    ax(i) = nexttile;
    hold on;
    plot(corruption_sigma, glr_accuracy(i, :), "black");
    plot(corruption_sigma, gtv_accuracy(i, :), "blue");
    plot(corruption_sigma, proposal_accuracy(i, :), "red");
    title("random seed = " + num2str(random_seed(i)));
end

parameter_description_axis = nexttile;
axis(parameter_description_axis, "off");
parameter_description = "Parameters: " + newline + ...
                        "random_seed = " + num2str(random_seed(1)) + ":" + num2str(random_seed(end)) + newline + ...
                        "corruption_sigma = " + num2str(corruption_sigma(1)) + ":" + num2str(corruption_sigma(end)) + newline + ...
                        "kernel_variance = " + num2str(experiment_config.kernel_variance) + newline + ...
                        "corruption_method: additive" + newline + ...
                        "corruption_rate = " + num2str(experiment_config.corruption_rate) + newline + ...
                        "masking_rate = " + num2str(experiment_config.masking_rate) + newline + ...
                        "sigma = " + num2str(experiment_config.sigma) + newline + ...
                        "alpha = " + num2str(proposal_config.alpha) + newline;
text(parameter_description_axis, 0.0, 0.5, parameter_description, ...
     "HorizontalAlignment", "left", ...
     "VerticalAlignment", "middle", ...
     "FontSize", 10, ...
     "Interpreter", "none");

% graph_description_axis = nexttile;
% axis(graph_description_axis, "off");
% graph_description = "Horizontal axis: corruption_sigma" + newline + ...
%                     "Vertical axis: MSE" + newline + ...
%                     "Black: GLR" + newline + ...
%                     "Blue: GTV" + newline + ...
%                     "Red: Proposal";
% text(graph_description_axis, 0.0, 0.5, graph_description, ...
%      "HorizontalAlignment", "left", ...
%      "VerticalAlignment", "middle", ...
%      "FontSize", 10, ...
%      "Interpreter", "none");

linkaxes(ax(1:numel(random_seed)));
end