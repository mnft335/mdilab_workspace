function plot_graph(G, true_signal, observed_signal, restored_signal)
    figure;

    subplot(1, 3, 1);
    gsp_plot_signal(G, true_signal);
    clim([0, 1]);
    colorbar("off");
    colorbar("North");
    title("Original");

    subplot(1, 3, 2);
    gsp_plot_signal(G, observed_signal);
    clim([0, 1]);
    colorbar("off");
    colorbar("North");
    title("Observed");

    subplot(1, 3, 3);
    gsp_plot_signal(G, restored_signal);
    clim([0, 1]);
    colorbar("off");
    colorbar("North");
    title("Restored");
end