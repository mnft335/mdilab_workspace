city_name = "Rome";

load(path_search(city_name));

G = gsp_graph(double(W), pos);

figure;
gsp_plot_signal(G, data(:, 1));
title(city_name, FontSize=16);