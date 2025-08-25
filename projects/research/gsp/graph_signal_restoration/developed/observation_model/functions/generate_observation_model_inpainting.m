function observation_model_inpainting = generate_observation_model_inpainting(signal_mask, generate_signal_noise)

    % Create an observation operator that masks a signal and its adjoint operator
    observation_model_inpainting.observation_operator = @(z) signal_mask .* z;
    observation_model_inpainting.observation_operator_adjoint = @(z) signal_mask .* z;

    % Generate signal noise
    observation_model_inpainting.signal_noise = assign_partial_data(signal_mask, signal_mask ~= 0, generate_signal_noise([sum(signal_mask ~= 0), 1]));

end