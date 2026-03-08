% DEMO_GRAPHS TSP論文等のGSP系研究で用いるグラフモデル生成のデモ
% 各自の `generate_rgg`, `generate_sbm`, `generate_ba` を呼び出し、結果を図示します。

clear; clc; close all;

%% 1. Random Geometric Graph (RGG) の生成と描画
N_rgg = 500;
r = 0.08;
[A_rgg, coords] = generate_rgg(N_rgg, r);

figure;
subplot(1, 3, 1);
G_rgg = graph(A_rgg);
% RGGはノードの座標 (coords) をもとに描画
plot(G_rgg, 'XData', coords(:,1), 'YData', coords(:,2), 'NodeColor', 'b', 'MarkerSize', 4);
title('Random Geometric Graph (RGG)');
axis equal; axis off;

%% 2. Stochastic Block Model (SBM) の生成と描画
% 3つのクラスタで構成される例
cluster_sizes = [150, 100, 120];
% 接続確率行列 (対角成分がクラスタ内、非対角成分がクラスタ間)
P = [0.15,  0.01,  0.005;
    0.01,  0.10,  0.02;
    0.005, 0.02,  0.12];
[A_sbm, labels] = generate_sbm(cluster_sizes, P);

subplot(1, 3, 2);
G_sbm = graph(A_sbm);
% SBMは力学モデルレイアウトで描画
p_sbm = plot(G_sbm, 'Layout', 'force', 'MarkerSize', 4);
title('Stochastic Block Model (SBM)');
axis equal; axis off;

% クラスタごとに色分け
colors = lines(length(cluster_sizes));
for i = 1:length(cluster_sizes)
    highlight(p_sbm, find(labels == i), 'NodeColor', colors(i,:));
end

%% 3. Barabasi-Albert (BA) scale-free graph の生成と描画
N_ba = 300;
m0 = 5;
m = 2;
A_ba = generate_ba(N_ba, m0, m);

subplot(1, 3, 3);
G_ba = graph(A_ba);
% BAモデルはハブノードが中心になるように力学モデルで描画
plot(G_ba, 'Layout', 'force', 'NodeColor', 'r', 'MarkerSize', 4);
title('Barabasi-Albert (BA) Graph');
axis equal; axis off;

% 全体のサイズとタイトルの調整
set(gcf, 'Position', [100, 100, 1200, 400]);
sgtitle('Generative Graph Models for GSP (TSP Paper)');
fprintf('グラフの描画が完了しました。\n');
