function plot_status(iter, relative_error, mse)
    figure;
    subplot(2, 1, 1);
    semilogx(1:iter, relative_error(1:iter));
    title("Relative error");

    subplot(2, 1, 2);
    semilogx(1:iter, mse(1:iter));
    title("MSE");
end