function figure_object = plot_for_paper(plot_object)

    % Get a handle for a new figure
    figure_object = figure;

    % Set the figure size in inches
    width = 3.5;
    height = 2.5;
    set(figure_object, 'Units', 'inches', 'Position', [0, 0, width, height]);

    % Get a handle for a new axes object associated with the figure
    axes_object = axes(figure_object);

    % Assign the plot object to the axes
    plot_object.Parent = axes_object;

    % Disable any surroundings
    box(axes_object, 'off');
    axes_object.XColor = 'none';
    axes_object.YColor = 'none';
    axes_object.XTick  = [];
    axes_object.YTick  = [];

    % Tighten the margins around the plot
    axes_object.LooseInset = axes_object.TightInset;

    % Shrink the bounding box
    axis(axes_object, 'tight');

end