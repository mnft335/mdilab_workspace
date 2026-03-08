function A = generate_ba(N, m0, m)
% GENERATE_BA Barabasi-Albert (BA) モデルに従うスケールフリーグラフを生成します。
%
% [入力]
% N: 最終的なノード総数
% m0: 初期状態の完全グラフのノード数
% m: 新しいノードを追加する際に張るエッジ数 (m <= m0)
%
% [出力]
% A: 生成されたグラフの隣接行列 (N x N)

if m > m0
    error('mはm0以下である必要があります。');
end

A = zeros(N, N);

% 初期状態：m0個のノードからなる完全グラフ
A(1:m0, 1:m0) = ones(m0, m0) - eye(m0);

% 次数の初期化
degrees = sum(A(1:m0, 1:m0));

% 優先的選択 (Preferential attachment) によりノードを順次追加
for i = m0 + 1 : N
    % 現在の各ノードの次数に基づく接続確率を計算
    prob = degrees / sum(degrees);

    % 接続先のノードを重み付きランダム抽出・非復元で m 個選択する処理
    targets = zeros(1, m);
    temp_prob = prob;
    for k = 1:m
        cum_prob = cumsum(temp_prob);
        r = rand();
        idx = find(cum_prob >= r, 1);

        % 浮動小数点誤差等で探せなかった場合のフェイルセーフ
        if isempty(idx)
            idx = find(temp_prob > 0, 1, 'last');
        end

        % 選択したノードをターゲットに追加
        targets(k) = idx;

        % 多重エッジを防ぐため、一度選ばれたノードの確率を0にする
        temp_prob(idx) = 0;

        % 残りの確率を再正規化
        if sum(temp_prob) > 0
            temp_prob = temp_prob / sum(temp_prob);
        end
    end

    % エッジの追加（無向グラフ）
    A(i, targets) = 1;
    A(targets, i) = 1;

    % 次数の更新
    degrees(targets) = degrees(targets) + 1; % 接続された既存ノードの次数増加
    degrees = [degrees, m]; % 新しいノード自身の次数(m)を末尾に追加
end
end
