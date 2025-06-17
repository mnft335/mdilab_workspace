clear;

gsp_start();

load("minnesota_graph.mat");
G = gsp_adj2vec(G);
V = G.N;
E = G.Ne;
u_true = G.org_signal;
W = diag(G.weights);
D = G.Diff;
WD = W * D;

masking_rate = round(0.5 * V);
mask = ones(V, 1);
mask(randperm(V, masking_rate)) = 0;

Phi = @(z) mask .* z;
Phit = @(z) mask .* z;

sigma = 0.25;

gamma_x1 = 0.1;
gamma_x2 = 0.1;
gamma_y1 = 1 / 30 * gamma_x1;
gamma_y2 = 1 / 30 * gamma_x2;
alpha = 0.4;
b = Phi(u_true + sigma * randn(size(u_true)));
epsilon = norm(Phi(u_true) - b);
lower = 0;
upper = 1;
x_init = {zeros(V, 1), zeros(E, 1)};
y_init = {zeros(E, 1), zeros(V, 1)};
stopping_criteria = @(obj) IterationLimit(20000).check();;
GLRSolver = pro_factory(WD, Phi, Phit, gamma_x1, gamma_x2, gamma_y1, gamma_y2, alpha, b, epsilon, lower, upper, x_init, y_init, stopping_criteria);
GLRSolver.solve();