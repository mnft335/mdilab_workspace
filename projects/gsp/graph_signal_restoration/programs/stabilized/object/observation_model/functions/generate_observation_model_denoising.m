function observation_model_denoising = generate_observation_model_denoising(graph, generate_signal_noise, std_dev_signal_noise)

    % Create an observation operator that is an identity operator and its adjoint operator
    observation_model_denoising.observation_operator = @(z) z;
    observation_model_denoising.observation_operator_adjoint = @(z) z;

    % Generate signal noise
    observation_model_denoising.signal_noise = generate_signal_noise(zeros(graph.N, 1));

    % Assign the standard deviation of the signal noise
    observation_model_denoising.std_dev_signal_noise = std_dev_signal_noise;

end