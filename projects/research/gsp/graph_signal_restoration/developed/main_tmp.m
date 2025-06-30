clear;

for i = 1:1

rng(i);

shared_config = shared_config_factory();
glr_config = struct();
gtv_config = struct();
proposal_config.alpha = 0.5;

glr_solved = solve_glr(shared_config, glr_config);
gtv_solved = solve_gtv(shared_config, gtv_config);
% proposal_solved = solve_proposal(shared_config, proposal_config);

plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, glr_solved.x{1});
plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, gtv_solved.x{1});
% plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, proposal_solved.x{1});

glr_solved.accuracy(end)
gtv_solved.accuracy(end)
% proposal_solved.accuracy(end)

% disp(norm(shared_config.G.weights .* shared_config.G.Diff * gtv_solved.x{1}, 1));
% disp(proposal_config.alpha * norm(shared_config.G.weights .* shared_config.G.Diff * proposal_solved.x{1} - shared_config.G.weights .* proposal_solved.x{2}, 1) + (1 - proposal_config.alpha) * sum((shared_config.G.weights .* proposal_solved.x{2}).^2));

end