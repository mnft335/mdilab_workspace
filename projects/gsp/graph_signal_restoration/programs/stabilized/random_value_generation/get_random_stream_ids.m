function random_stream_ids = get_random_stream_ids()

    % Define a name-ID map for random streams
    random_stream_ids = containers.Map;
    random_stream_ids("generate_true_forward_weights:gaussian") = 100;
    random_stream_ids("generate_true_forward_weights:uniform") = 200;
    random_stream_ids("generate_true_forward_weights:truncated_gaussian") = 300;
    random_stream_ids("generate_smooth_sampling_coefficients:gaussian") = 400;
    random_stream_ids("generate_smooth_sampling_coefficients:uniform") = 500;
    random_stream_ids("generate_smooth_sampling_coefficients:truncated_gaussian") = 600;
    random_stream_ids("generate_idx_forward_weights_to_corrupt") = 700;
    random_stream_ids("generate_forward_weight_noise:gaussian") = 800;
    random_stream_ids("generate_forward_weight_noise:uniform") = 900;
    random_stream_ids("generate_forward_weight_noise:truncated_gaussian") = 1000;
    random_stream_ids("generate_idx_signal_to_mask") = 1100;
    random_stream_ids("generate_signal_noise") = 1200;
    random_stream_ids("generate_idx_initial_forward_weights_to_modify") = 1300;

end