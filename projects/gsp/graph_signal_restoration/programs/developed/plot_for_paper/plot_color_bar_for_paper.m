figure_object = figure;
height = 2.5;
set(figure_object, 'Units', 'inches', 'Position', [0, 0, 1.5, height]);
axes_object = axes(figure_object, "Visible", "off");
color_bar = colorbar(axes_object);
color_bar.Ticks = [0, 0.1, 0.2];
color_bar.TickLabels = ["0", "0.1", "0.2"];
color_bar.FontSize = 16;
colormap(figure_object, create_red_color_map(256));
caxis(axes_object, [0, 0.2]);

exportgraphics(figure_object, fullfile("projects\research\gsp\graph_signal_restoration\resources\data\images\color_bar", "red.jpg"));
exportgraphics(figure_object, fullfile("projects\research\gsp\graph_signal_restoration\resources\data\images\color_bar", "red.eps"), "ContentType", "vector", "BackgroundColor", "none");

figure_object = figure;
height = 2.5;
set(figure_object, 'Units', 'inches', 'Position', [0, 0, 1.5, height]);
axes_object = axes(figure_object, "Visible", "off");
color_bar = colorbar(axes_object);
color_bar.Ticks = [0, 0.5, 1];
color_bar.TickLabels = ["0", "0.5", "1"];
color_bar.FontSize = 16;
colormap(figure_object, jet(256));
caxis(axes_object, [0, 1]);

exportgraphics(figure_object, fullfile("projects\research\gsp\graph_signal_restoration\resources\data\images\color_bar", "jet.jpg"));
exportgraphics(figure_object, fullfile("projects\research\gsp\graph_signal_restoration\resources\data\images\color_bar", "jet.eps"), "ContentType", "vector", "BackgroundColor", "none");