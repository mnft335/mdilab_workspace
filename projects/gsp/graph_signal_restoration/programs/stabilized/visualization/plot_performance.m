function plot_performance(baselines, performances)

    % Line styles for the baselines
    line_styles = {"-", "--", ":", "-."};

    % Line colors for the performances
    line_colors = {"red", "green", "blue", "cyan"};

    % Create a figure object
    figure_object = figure;
    figure_object.WindowState = "maximized";

    % Create an axes object and set the range in the y-axis to [0, 1]
    axes_object = axes(figure_object);
    axes_object.YLim = [0, 1];

    % Hold the plot to overlay multiple lines
    hold(axes_object, "on");

    % Plot the baselines
    for i = 1:numel(baselines)

        constant_line_object = yline(axes_object, baselines(i));
        constant_line_object.Color = "black";
        constant_line_object.LineStyle = line_styles{i};

    end

    % Plot the performances
    for i = 1:size(performances, 2)

        line_object = plot(axes_object, performances(:, i));
        line_object.Color = line_colors{i};

    end

    hold(axes_object, "off");

end