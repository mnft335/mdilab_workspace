path_result_to_plot = "projects\research\gsp\graph_signal_restoration\resources\data\result_to_plot\result_to_plot.mat";
result_to_plot = load_file(path_result_to_plot);

result_collection = struct2cell(result_to_plot);

for i = 1:length(result_collection)
    
    true_signal = result_collection{i}.object_collection.true_signal;
    restored_signal = result_collection{i}.solution.x{1};
    restoration_residual = true_signal - restored_signal;
    max(abs(restoration_residual))
    
end