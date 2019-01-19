% inicializace
x = 0:0.1:2*pi;
y = zeros(size(x));

% parametry
N = 5;
centers = linspace(x(1),x(end),N);
widths = 2*(x(1)-x(end))*ones(size(centers))/(N-1);
ys = sin(centers);

% inference
for i = 1:length(x)
    mu = calc_mf(x(i),centers,widths);
    y(i) = mu*ys'/sum(mu);
end

figure(1)
    plot(x,y)