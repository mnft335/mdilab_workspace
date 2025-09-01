function plot_graph(G, true_signal, observed_signal, restored_signal)

    % Create a figure with minimal spacing and padding
    figure;
    tiledlayout(1, 3, "TileSpacing", "tight", "Padding", "tight");

    % Plot the original, observed, and restored signals
    nexttile;
    gsp_plot_signal(G, true_signal);
    clim([0, 1]);
    colorbar("off");
    title("Original");

    nexttile;
    gsp_plot_signal(G, observed_signal);
    clim([0, 1]);
    colorbar("off");
    title("Observed");

    nexttile;
    gsp_plot_signal(G, restored_signal);
    clim([0, 1]);
    colorbar("off");
    title("Restored");

end