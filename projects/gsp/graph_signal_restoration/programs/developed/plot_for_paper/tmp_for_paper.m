path_result_to_plot = "projects\research\gsp\graph_signal_restoration\resources\data\result_to_plot\result_to_plot.mat";
result_to_plot = load_file(path_result_to_plot);

result_collection = struct2cell(result_to_plot);
field_names = fieldnames(result_to_plot);

for i = 1:length(result_collection)
    
    nmse(i) = compute_nmse_from_result(result_collection{i});

end