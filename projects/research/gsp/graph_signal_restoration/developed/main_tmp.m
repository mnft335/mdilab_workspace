clear;

rng(0);


% masking_rate = 0.0:0.1:0.9;
% corruption_rate = 0.0:0.1:0.9;
masking_rate = [0.0];
corruption_rate = [0.0];

for i = masking_rate;
    
    glr_accuracy = [];
    gtv_accuracy = [];
    proposal_accuracy = [];

    for j = corruption_rate;
        experiment_config.masking_rate = i;
        experiment_config.corruption_rate = j;
        experiment_config.sigma = 0.25;

        shared_config = shared_config_factory(experiment_config);
        glr_config = struct();
        gtv_config = struct();
        proposal_config.alpha = 0.5;

        glr_solved = solve_glr(shared_config, glr_config);
        gtv_solved = solve_gtv(shared_config, gtv_config);
        proposal_solved = solve_proposal(shared_config, proposal_config);

        plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, glr_solved.x{1});
        plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, gtv_solved.x{1});
        plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, proposal_solved.x{1});

        disp("Final accuracy of glr: " + num2str(glr_solved.accuracy(end)));
        disp("Final accuracy of gtv: " + num2str(gtv_solved.accuracy(end)));
        disp("Final accuracy of proposal: " + num2str(proposal_solved.accuracy(end)));

        glr_accuracy(end + 1) = glr_solved.accuracy(end);
        gtv_accuracy(end + 1) = gtv_solved.accuracy(end);
        proposal_accuracy(end + 1) = proposal_solved.accuracy(end);
    end

    figure;
    tiledlayout(3,1);
    ax1 = nexttile;
    plot(corruption_rate, glr_accuracy);
    ax2 = nexttile;
    plot(corruption_rate, gtv_accuracy);
    ax3 = nexttile;
    plot(corruption_rate, proposal_accuracy);
end