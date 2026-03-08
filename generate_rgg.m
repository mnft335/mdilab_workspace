function [A, coords] = generate_rgg(N, r)
    % GENERATE_RGG Random Geometric Graph (RGG) を生成します。
    %
    % [入力]
    % N: ノード数
    % r: 接続距離のしきい値 (例: 0.1)
    %
    % [出力]
    % A: 生成されたグラフの隣接行列 (N x N)
    % coords: ノードの2次元座標 (N x 2)
    
    % [0, 1] x [0, 1] の空間にノードをランダム（一様分布）に配置
    coords = rand(N, 2);
    
    % ユークリッド距離行列の計算
    D = pdist2(coords, coords);
    
    % 距離が r 以下のノード間にエッジを張る (自己ループは除く)
    A = double((D <= r) & ~eye(N));
end
