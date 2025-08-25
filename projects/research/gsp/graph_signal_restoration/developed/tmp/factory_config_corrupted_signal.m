function config_corrupted_signal = factory_config_corrupted_signal(master_seed, param_generate_signal_mask, param_generate_signal_noise)

    % Obtain a function handle that returns the specified random stream
    get_random_stream = factory_get_random_stream(master_seed);

    % Obtain the "generate_signal_mask" handle
    param_generate_signal_mask.get_random_stream = get_random_stream;

    config_corrupted_signal.generate_signal_mask = factory_generate_signal_mask(param_generate_signal_mask);
    
    % Obtain the "generate_signal_noise" handle
    param_generate_signal_noise.get_random_stream = get_random_stream;

    config_corrupted_signal.generate_signal_noise = factory_generate_signal_noise(param_generate_signal_noise);

end