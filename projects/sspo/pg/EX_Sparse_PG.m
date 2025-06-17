clear
% close

n = 100; % スパースベクトルの次元 (dimension of a sparse vector)
k = n/4; % 観測ベクトルの次元 (dimension of an observed vector)
sigma = 0.01; % 白色ガウス雑音の標準偏差 (standard deviation of Gaussian noise)

% スパースベクトル作成 (generate a sparse vector to be estimated)
sprate = 0.05; %非ゼロ要素の割合 (rate of nonzero entries)
nnznum = round(sprate*n); %非ゼロ要素数 (number of nonzero entries)
supp = randperm(n,nnznum); %非ゼロ要素のサポート (support of nonzer entries)
ut = zeros(n,1);
ut(supp) = 2*(round(rand(nnznum,1))-0.5); %所望のスパース信号 (sparse vector to be estimated)

% 観測データの作成 (generate an observed vector)
Phi = randn(k,n); % 観測行列 (observation matrix)
v = Phi*ut + sigma*randn(k,1); % 観測ベクトル (observed vector)

% アルゴリズム (algorithm)
lambda = 1; % L1ノルムの重要度 (weight of L1 norm)
gamma = 2/(svds(Phi,1)^2 + 10); % ステップサイズ (stepsize)
iter = 5000; % 反復数 (number of iterations)
u0 = Phi\v; % 初期解 = 最小二乗解 (initial solution)
u = u0;
%%%%%%%%%%%%%!!! Excercise !!!%%%%%%%%%%%%%%%%%%%%
import prox.prox_l1
for i = 1:iter
    w = u - gamma * Phi.' * (Phi * u - v);
    u = prox_l1(w, gamma, lambda);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 結果をプロット (plot results)
figure(1);
subplot(1,3,1), plot(ut),ylim([-1,1]);
subplot(1,3,2), plot(u0),ylim([-1,1]);
subplot(1,3,3), plot(u),ylim([-1,1]);
axis([1,100,-1,1]);

