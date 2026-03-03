path_result_to_plot = "projects\research\gsp\graph_signal_restoration\resources\data\result_to_plot\result_to_plot.mat";
result_to_plot = load_file(path_result_to_plot);

result_collection = struct2cell(result_to_plot);

result = result_collection{1};

% plot_object = plot_true_signal_for_paper(result);
% figure_object = plot_for_paper(plot_object);
% exportgraphics(figure_object, "projects\research\gsp\graph_signal_restoration\resources\data\images\qualitative_experiment\true_signal.png", "Resolution", 300);
% exportgraphics(figure_object, "projects\research\gsp\graph_signal_restoration\resources\data\images\qualitative_experiment\true_signal.eps", "ContentType", "vector", "BackgroundColor", "none");

plot_object = plot_observed_signal_for_paper(result);
figure_object = plot_for_paper(plot_object);
exportgraphics(figure_object, "projects\research\gsp\graph_signal_restoration\resources\data\images\qualitative_experiment\observed_signal.png", "Resolution", 300);
exportgraphics(figure_object, "projects\research\gsp\graph_signal_restoration\resources\data\images\qualitative_experiment\observed_signal.eps", "ContentType", "vector", "BackgroundColor", "none");