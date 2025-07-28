clear
%close

%% set of parameters
lambda = 0.01; % regularization parameter
beta = 1; % Lipschitz constant
opDtD = 8; % operator norm of DtD
gamma1 = 0.8; % stepsize of PDS
gamma2 = 0.99/(gamma1*opDtD) - beta/(2*opDtD);
iter = 5000; % max number of iterations
stopcri = 1e-5; % stopping criterion

%% observation generation
imname = 'culicoidae.png'; % original image
u_org = double(imread(imname))/255;
[rows, cols] = size(u_org);
N = rows*cols;

% randam decimation operator
K = round(N/2); % decimation rate
I = randperm(N);
Phi = @(z) z(I(1:K))'; % decimation operator
Phit = @(z) deci_trans(z,I,K,rows,cols); % transpose of Phi

sigma = 10/255; % noise standard deviation
v = Phi(u_org) + sigma*randn(K,1); % observation (decimation+noise)

%% initialization

% difference operator
D = @(z) cat(3, z([2:rows, 1],:) - z, z(:,[2:cols, 1])-z);
Dt = @(z) [-z(1,:,1)+z(rows,:,1); - z(2:rows,:,1) + z(1:rows-1,:,1)] ...
    +[-z(:,1,2)+z(:,cols,2), - z(:,2:cols,2) + z(:,1:cols-1,2)];

% variables
u = Phit(v);
z = D(u);

%% main loop%%
%%%%%%%%%%%%%!!! Excercise !!!%%%%%%%%%%%%%%%%%%%%
import prox.*
for i = 1:iter
    u_prev = u;
    argument_u = u - gamma1 * (Phit(Phi(u) - v) + Dt(z));
    u = prox_box(argument_u, 0, 1);

    argument_z = z + gamma2 * D(2 * u - u_prev);
    z = argument_z - gamma2 * prox_l1(argument_z ./ gamma2, 1 ./ gamma2, lambda);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% result plot
 

disp(['PSNR = ', num2str(psnr(u,u_org,1),4)]);

figure(1);
subplot(1,3,1), imshow(u_org), title('original');
subplot(1,3,2), imshow(Phit(v)), title('observation');
subplot(1,3,3), imshow(u), title('restored');

function[y] = deci_trans(x,I,K,rows,cols)
 y = zeros(rows,cols);
 y(I(1:K)) = x;
end
