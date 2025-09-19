figure_object = figure;
height = 2.5;
set(figure_object, 'Units', 'inches', 'Position', [0, 0, 0.5, height]);
axes_object = axes(figure_object, "Visible", "off");
color_bar = colorbar(axes_object);
colormap(figure_object, jet);
caxis(axes_object, [0, 1]);

exportgraphics(figure_object, fullfile("projects\research\gsp\graph_signal_restoration\resources\data\images\color_bar", "color_bar.jpg"));
exportgraphics(figure_object, fullfile("projects\research\gsp\graph_signal_restoration\resources\data\images\color_bar", "color_bar.eps"), "ContentType", "vector", "BackgroundColor", "none");