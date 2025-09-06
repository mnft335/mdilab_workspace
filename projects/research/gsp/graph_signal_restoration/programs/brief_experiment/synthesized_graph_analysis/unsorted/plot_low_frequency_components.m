function plot_low_frequency_components()

    % Load all synthesized graphs
    path_graph_collection = load_path_graph_collection();

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
            gsp_plot_signal(path_graph_collection{i}, create_true_signal(path_graph_collection{i}.U(:, j)));
            clim([0, 1]);
            colorbar("off");
            title(sprintf("%s", field_name{i}), "interpreter", "none");

        end

    end

end