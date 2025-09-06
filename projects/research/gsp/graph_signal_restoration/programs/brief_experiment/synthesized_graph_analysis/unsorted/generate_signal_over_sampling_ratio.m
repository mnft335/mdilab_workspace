function signal_over_sampling_ratio = generate_signal_over_sampling_ratio(path_graph_collection)

    % Define the range of sampling ratios
    range_sampling_ratio = 0.1:0.1:1.0;

    % Preallocate the returned array
    signal_over_sampling_ratio = cell(5, numel(range_sampling_ratio));

    for i = 1:numel(range_sampling_ratio)

        % Specify the smooth sampler configuration
        param.true_signal.type = "smooth_sampling";
        param.true_signal.smooth_sampling_coefficients.type = "gaussian";
        param.true_signal.smooth_sampling_coefficients.std_dev = 1;
        param.true_signal.smooth_sampling_coefficients.sampling_ratio = range_sampling_ratio(i);
        param.true_signal.smooth_sampling_coefficients.random_seed = 1;

        % Create a smooth sampler generator
        config_true_signal = factory_config_true_signal(param.true_signal, []);
        smooth_sampler = config_true_signal.generate_true_signal;

        % Generate smooth signals
        signal_over_sampling_ratio{1, i} = smooth_sampler(path_graph_collection.path_graph_uniform);
        signal_over_sampling_ratio{2, i} = smooth_sampler(path_graph_collection.path_graph_1_spike);
        signal_over_sampling_ratio{3, i} = smooth_sampler(path_graph_collection.path_graph_single_drop);
        signal_over_sampling_ratio{4, i} = smooth_sampler(path_graph_collection.path_graph_11_spikes);
        signal_over_sampling_ratio{5, i} = smooth_sampler(path_graph_collection.path_graph_1single_drops);

    end

end