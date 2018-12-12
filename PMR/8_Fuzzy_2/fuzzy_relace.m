tic
x = -5:0.2:5;
y = -5:0.2:5;

[X,Y] = meshgrid(x,y);

funAE = @(x,y) exp(-(x-y).^2);   % x je p�ibli�n� y
funML = @(x,y) 1/(1+exp(-x+y));  % x je mnohem men�� ne� y

fAE = arrayfun(@(x,y) funAE(x,y), X, Y);
fML = arrayfun(@(x,y) funML(x,y), X, Y);
toc

figure(1)
    subplot(211)
        surfc(x,y,fAE')
        title('x je p�ibli�n� y')
        xlabel('x')
        ylabel('y')
    subplot(212)
        surfc(x,y,fML')
        title('x je mnohem men�� y')
        xlabel('x')
        ylabel('y')
