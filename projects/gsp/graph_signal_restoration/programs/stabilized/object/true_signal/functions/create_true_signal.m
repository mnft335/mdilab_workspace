function true_signal = create_true_signal(raw_signal)

    % Shift the signal to make the minimum larger than 0
    true_signal = raw_signal + max(0, max(- raw_signal));

    % Normalize the signal to make the maximum to be 1
    true_signal = true_signal ./ max(true_signal);

end