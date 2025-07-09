function signal = generate_signal(W)

    G = gsp_graph(double(W));
    G = gsp_compute_fourier_basis(G);
    G = gsp_adj2vec(G);

    num_coefficients = 15;
    [~, low_frequency_indices] = sort(G.e);
    signal = G.U(:, low_frequency_indices(1:num_coefficients)) * randn(num_coefficients, 1);
    signal = (signal + abs(min(0, min(signal))));
    signal = signal ./ max(signal);

end