function signal = generate_clean_signal(generate_raw_signal)

    % Generate a raw graph signal
    signal = generate_raw_signal();

    % Shift the signal to make the minimum larger than 0
    signal = signal + max(0, max(- signal));

    % Normalize the signal to make the maximum to be 1
    signal = signal ./ max(signal);

end