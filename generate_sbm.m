function [A, labels] = generate_sbm(cluster_sizes, P)
% GENERATE_SBM Stochastic Block Model (SBM) に従うグラフを生成します。
%
% [入力]
% cluster_sizes: 各クラスタ(ブロック)のノード数を含むベクトル (1 x K)
% P: クラスタ間およびクラスタ内の接続確率行列 (K x K, 対称行列)
%
% [出力]
% A: 生成されたグラフの隣接行列 (N x N)
% labels: 各ノードが属するクラスタのラベル (N x 1)

K = length(cluster_sizes);
N = sum(cluster_sizes);

% ラベルの割り当て
labels = zeros(N, 1);
idx = 1;
for k = 1:K
    labels(idx : idx + cluster_sizes(k) - 1) = k;
    idx = idx + cluster_sizes(k);
end

% 隣接行列の初期化
A = zeros(N, N);

% クラスタ間・クラスタ内のエッジを確率 P(i,j) に基づき生成
for i = 1:K
    for j = i:K
        % i番目とj番目のクラスタに属するノードのインデックス
        idx_i = find(labels == i);
        idx_j = find(labels == j);

        % 確率行列に基づいてランダムな値を生成
        if i == j
            % クラスタ内エッジ (対称行列、自己ループなし)
            R = rand(length(idx_i), length(idx_i));
            block_A = double(R < P(i, j));
            block_A = triu(block_A, 1); % 上三角行列を取得して無向グラフ化
            block_A = block_A + block_A'; % 対称行列にする
            A(idx_i, idx_i) = block_A;
        else
            % クラスタ間エッジ
            R = rand(length(idx_i), length(idx_j));
            block_A = double(R < P(i, j));
            A(idx_i, idx_j) = block_A;
            A(idx_j, idx_i) = block_A'; % 対称行列にする
        end
    end
end
end
