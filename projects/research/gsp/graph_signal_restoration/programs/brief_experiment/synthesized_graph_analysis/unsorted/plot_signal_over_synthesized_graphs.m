function plot_signal_over_synthesized_graph()

    % Load all synthesized graphs
    path_graph_collection = load_path_graph_collection();

    % Generate graph signals from synthesized graphs
    signal_over_sampling_ratio = generate_signal_over_sampling_ratio(path_graph_collection);

    % Convert the "path_graph_collection" to a cell array, keeping the field names
    field_name = fieldnames(path_graph_collection);
    path_graph_collection = struct2cell(path_graph_collection);

    % Assign the coordinates to each graph
    coordinates = gsp_path(path_graph_collection{1}.N).coords;
    path_graph_collection = cellfun(@(z) setfield(z, "coords", coordinates), path_graph_collection, "UniformOutput", false);

    for i = 1:5

        % Create a figure with minimal spacing and padding
        figure;
        tiledlayout(2, 5, "TileSpacing", "tight", "Padding", "tight");

        for j = 1:10

            nexttile;
            gsp_plot_signal(path_graph_collection{i}, signal_over_sampling_ratio{i, j});
            clim([0, 1]);
            colorbar("off");
            title(sprintf("%s, %.1f", field_name{i}, 0.1 * j), "interpreter", "none");

        end

    end

end