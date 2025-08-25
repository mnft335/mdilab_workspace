function clean_signal = generate_clean_signal(generate_raw_signal)

    % Generate a raw signal
    raw_signal = generate_raw_signal();

    % Shift the signal to make the minimum larger than 0
    clean_signal = raw_signal + max(0, max(- raw_signal));

    % Normalize the signal to make the maximum to be 1
    clean_signal = clean_signal ./ max(clean_signal);

end