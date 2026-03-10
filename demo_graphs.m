% DEMO_GRAPHS Demo of generative graph models for GSP

clear; clc; close all;

%% 1. Random Geometric Graph (RGG)

num_nodes_rgg = 500;
distance_threshold = 0.08;

% Generate graph
[A_rgg, node_coordinates] = generate_rgg(num_nodes_rgg, distance_threshold, 42);

% Plot graph
figure;
subplot(1, 3, 1);
G_rgg = graph(A_rgg);
plot(G_rgg, 'XData', node_coordinates(:,1), 'YData', node_coordinates(:,2), 'NodeColor', 'b', 'MarkerSize', 4);
title('Random Geometric Graph (RGG)');
axis equal; axis off;

%% 2. Stochastic Block Model (SBM)

cluster_sizes = [150, 100, 120];
connection_probabilities = [0.15,  0.01,  0.005;
                            0.01,  0.10,  0.02;
                            0.005, 0.02,  0.12];

% Generate graph
[A_sbm, labels] = generate_sbm(cluster_sizes, connection_probabilities, 123);

% Plot graph
subplot(1, 3, 2);
G_sbm = graph(A_sbm);
p_sbm = plot(G_sbm, 'Layout', 'force', 'MarkerSize', 4);
title('Stochastic Block Model (SBM)');
axis equal; axis off;

% Color nodes by cluster
colors = lines(length(cluster_sizes));
for i = 1:length(cluster_sizes)
    highlight(p_sbm, find(labels == i), 'NodeColor', colors(i,:));
end

%% 3. Barabasi-Albert (BA)

num_nodes_ba = 300;
num_initial_nodes = 5;
num_edges_to_add = 2;

% Generate graph
A_ba = generate_ba(num_nodes_ba, num_initial_nodes, num_edges_to_add, 999);

% Plot graph
subplot(1, 3, 3);
G_ba = graph(A_ba);
plot(G_ba, 'Layout', 'force', 'NodeColor', 'r', 'MarkerSize', 4);
title('Barabasi-Albert (BA)');
axis equal; axis off;

% Final layout adjustments
set(gcf, 'Position', [100, 100, 1200, 400]);
sgtitle('Generative Graph Models for GSP (TSP Paper)');
fprintf('Graph rendering completed.\n');
