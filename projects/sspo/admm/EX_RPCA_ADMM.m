clear
%close

%% image loading
M = double(imread('brick.png'))/255;
imsize = size(M);

%% set of parameters
lambda = 0.04; % weight for the l1 norm
gamma = 1; % stepsize of ADMM
iter = 200; % number of iterations

%% initialization
L = zeros(imsize); % low-rank matrix
S = zeros(imsize); % sparse matrix

Z1 = zeros(imsize);
Z2 = zeros(imsize);
Z3 = zeros(imsize);

Y1 = zeros(imsize);
Y2 = zeros(imsize);
Y3 = zeros(imsize);

%% algorithm
%%%%%%%%%%%%%!!! Excercise !!!%%%%%%%%%%%%%%%%%%%%
% for i = 1:iter
%     import prox.*
%     L = 1 ./ 3 * (2 * (Z1 - Y1) - (Z2 - Y2) + (Z3 - Y3));
%     S = 1 ./ 3 * (- (Z1 - Y1) + 2 * (Z2 - Y2) + (Z3 - Y3));
%     Z1 = prox_nuclear(L + Y1, gamma, 1);
%     Z2 = prox_l1(S + Y2, gamma, lambda);
%     Z3 = M;
%     Y1 = L - Z1 + Y1;
%     Y2 = S - Z2 + Y2;
%     Y3 = L + S - Z3 + Y3;
% end
Y = zeros(imsize);
for i = 1:iter
    import prox.*
    L = prox_nuclear(M - S - Y, 1 ./ gamma, 1);
    S = prox_l1(M - L - Y, 1 ./ gamma, lambda);
    Y = S + L - M + Y;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% plot results
figure(1)
subplot(1,3,1), imshow(M)
subplot(1,3,2), imshow(L)
subplot(1,3,3), imshow(S)
