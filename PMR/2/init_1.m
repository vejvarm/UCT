%
x10 = 1;
x20 = 10;

sim('stabilita_1')


figure(1)
    hold on
    plot(x1.Data, x2.Data)
    xlabel('x1')
    ylabel('x2')
    grid on


