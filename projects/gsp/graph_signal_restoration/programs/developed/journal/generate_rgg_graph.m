function [W, coords] = generate_rgg_graph(N, radius, sigma)
% GENERATE_RGG_GRAPH Generates a Random Geometric Graph (RGG) for GSP.
%
% Inputs:
%   N      - Number of nodes in the graph
%   radius - The connection radius/threshold (d(i,j) <= radius)
%   sigma  - (Optional) Width of the Gaussian kernel for edge weights. 
%            Defaults to radius / 2.
%
% Outputs:
%   W      - An N x N symmetric sparse weighted adjacency matrix
%   coords - An N x 2 matrix containing the 2D coordinates of the nodes
%
% Description:
%   This function uniformly scatters N nodes in a 2D unit square [0, 1]^2.
%   Nodes i and j are connected by an edge if the Euclidean distance 
%   between them is less than or equal to 'radius'. The edges are assigned 
%   weights based on a Gaussian kernel: W(i,j) = exp(-d(i,j)^2 / (2*sigma^2)).

    if nargin < 3
        sigma = radius / 2;
    end

    % 1. Uniformly scatter N nodes in the 2D unit square
    coords = rand(N, 2);

    % 2. Compute pairwise Euclidean distance between all nodes
    X = coords(:, 1);
    Y = coords(:, 2);
    
    % Using implicit expansion (or bsxfun for older MATLAB versions)
    DX = X - X'; 
    DY = Y - Y';
    D = sqrt(DX.^2 + DY.^2);

    % 3. Find node pairs that are within the connection radius
    % Also remove self-loops (diagonal elements)
    adjacency_mask = (D <= radius) & ~eye(N);

    % 4. Assign Gaussian weights to the valid edges
    W = zeros(N, N);
    weights = exp(-(D.^2) / (2 * sigma^2));
    
    % Apply the threshold mask to form the final weight matrix W
    W(adjacency_mask) = weights(adjacency_mask);
    
    % 5. Convert to a sparse matrix for memory/computational efficiency
    W = sparse(W);

end
