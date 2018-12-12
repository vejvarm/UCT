tic
x = -5:0.2:5;
y = -5:0.2:5;

[X,Y] = meshgrid(x,y);

funAE = @(x,y) exp(-(x-y).^2);   % x je pøibližnì y
funML = @(x,y) 1/(1+exp(-x+y));  % x je mnohem menší než y

fAE = arrayfun(@(x,y) funAE(x,y), X, Y);
fML = arrayfun(@(x,y) funML(x,y), X, Y);
toc

figure(1)
    subplot(211)
        surfc(x,y,fAE')
        title('x je pøibližnì y')
        xlabel('x')
        ylabel('y')
    subplot(212)
        surfc(x,y,fML')
        title('x je mnohem menší y')
        xlabel('x')
        ylabel('y')
