% Template for "grid_param" to vary over
grid_param.corrupted_graph.type = "corrupt";
grid_param.corrupted_graph.forward_weight_corruption.type = "binary_flip";
grid_param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.type = "random";
grid_param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.corruption_ratio = 0.1:0.1:0.9;
grid_param.corrupted_graph.forward_weight_corruption.idx_to_corrupt.random_seed = 1;