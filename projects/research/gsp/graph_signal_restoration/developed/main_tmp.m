clear;

% masking_rate = 0.0:0.1:0.9;
% corruption_rate = 0.0:0.1:0.9;
% alpha = 0.002:0.002:0.1;
masking_rate = 0.5;
corruption_rate = 0.0;
alpha = 0.5;

for i = masking_rate;
    
    glr_accuracy = [];
    gtv_accuracy = [];
    proposal_accuracy = [];

    for j = corruption_rate;

        for k = alpha;

            rng(0);

            experiment_config.masking_rate = i;
            experiment_config.corruption_rate = j;
            experiment_config.sigma = 0.0;

            shared_config = shared_config_factory(experiment_config);
            glr_config = struct();
            % gtv_config = struct();
            proposal_config.alpha = k;

            glr_solved = solve_glr(shared_config, glr_config);
            % gtv_solved = solve_gtv(shared_config, gtv_config);
            proposal_solved = solve_proposal(shared_config, proposal_config);

            % plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, glr_solved.x{1});
            % plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, gtv_solved.x{1});
            % plot_graph(shared_config.G, shared_config.true_signal, shared_config.b, proposal_solved.x{1});

            figure;

            subplot(1, 5, 1);
            gsp_plot_signal(shared_config.G, shared_config.true_signal);
            clim([0, 1]);
            colorbar("off");
            colorbar("North");
            title("Original");

            subplot(1, 5, 2);
            gsp_plot_signal(shared_config.G, shared_config.b);
            clim([0, 1]);
            colorbar("off");
            colorbar("North");
            title("Observed");

            subplot(1, 5, 3);
            gsp_plot_signal(shared_config.G, glr_solved.x{1});
            clim([0, 1]);
            colorbar("off");
            colorbar("North");
            title("GLR");

            % subplot(1, 5, 4);
            % gsp_plot_signal(shared_config.G, gtv_solved.x{1});
            % clim([0, 1]);
            % colorbar("off");
            % colorbar("North");
            % title("GTV");

            subplot(1, 5, 5);
            gsp_plot_signal(shared_config.G, proposal_solved.x{1});
            clim([0, 1]);
            colorbar("off");
            colorbar("North");
            title("Proposal");

            disp("Final accuracy of glr: " + num2str(glr_solved.accuracy(end)));
            % disp("Final accuracy of gtv: " + num2str(gtv_solved.accuracy(end)));
            disp("Final accuracy of proposal: " + num2str(proposal_solved.accuracy(end)));

        %     glr_accuracy(end + 1) = glr_solved.accuracy(end);
        %     gtv_accuracy(end + 1) = gtv_solved.accuracy(end);
        %     proposal_accuracy(end + 1) = proposal_solved.accuracy(end);
        end
    end

    % figure;
    % plot(alpha, glr_accuracy(end) * ones(numel(alpha), 1));
    % hold on
    % plot(alpha, gtv_accuracy(end) * ones(numel(alpha), 1));
    % hold on
    % plot(alpha, proposal_accuracy);

    % figure;
    % tiledlayout(3,1);
    % ax1 = nexttile;
    % plot(corruption_rate, glr_accuracy);
    % title("GLR");
    % ax2 = nexttile;
    % plot(corruption_rate, gtv_accuracy);
    % title("GTV");
    % ax3 = nexttile;
    % plot(corruption_rate, proposal_accuracy);
    % title("Proposal");
end