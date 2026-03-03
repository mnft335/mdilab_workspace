clear;

path_result_to_plot = "projects\research\gsp\graph_signal_restoration\resources\data\result_to_plot\result_to_plot.mat";
path_image_registry = "projects\research\gsp\graph_signal_restoration\resources\data\images\qualitative_experiment\restored";
result_to_plot = load_file(path_result_to_plot);

field_names = fieldnames(result_to_plot);

for i = 1:length(field_names)

    result = result_to_plot.(field_names{i});

    graph_plot = plot_restored_signal_for_paper(result);
    figure_object = plot_for_paper(graph_plot);
    exportgraphics(figure_object, fullfile(path_image_registry, field_names{i} + ".eps"), "ContentType", "vector", "BackgroundColor", "none");

end