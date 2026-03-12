% GENERATE_RGG Generates a Random Geometric Graph (RGG)
%
% Inputs:
%   num_nodes:          Total number of nodes to generate
%   distance_threshold: Distance within which two nodes will be connected
%   random_seed:        Seed for the random number stream
%
% Outputs:
%   A:                  Adjacency matrix of the RGG
%   node_coordinates:   Spatial coordinates of the nodes in 2D space [0,1]x[0,1]
function [A, node_coordinates] = generate_rgg(num_nodes, distance_threshold, random_seed)

    % Define the stream name for this generator internally
    random_stream_name = 'hoge_rgg';

    % Create a random stream using the provided seed and internal name
    random_stream = create_random_stream(random_seed, random_stream_name);

    % Randomly distribute nodes in a 2D space [0, 1] x [0, 1]
    node_coordinates = rand(random_stream, num_nodes, 2);

    % Calculate the pairwise Euclidean distance between nodes
    D = pdist2(node_coordinates, node_coordinates);

    % Connect nodes that are within the distance threshold
    A = double((D <= distance_threshold) & ~eye(num_nodes));

end
