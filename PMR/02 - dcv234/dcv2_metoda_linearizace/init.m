close all
clear
x1s = linspace(-sqrt(3)-1,sqrt(3)+1,10);
x2s = linspace(-0.5,0.5,10);

% inicializace kontejner?
x1_out = cell(1, length(x1s));
x2_out = x1_out;
leg = strings(1, length(x1s));

% výpo?et výstup? soustavy
for i = 1:length(x1s)
    x10 = x1s(i);
    x20 = x2s(i);
    sim('systemModel')
    x1_out{i} = [x1.time x1.data];
    x2_out{i} = [x2.time x2.data];
    leg(i) = strcat('x_e=[',num2str(x10,2),', ',num2str(x20,2),']');
end
    
figure(1)
    subplot(211)
        hold on
        cellfun(@(x) plot(x(:,1),x(:,2)), x1_out)
        hold off
        title('Prechodove charakteristiky x_1 pro ruzne poc. podminky')
        xlabel('cas (s)')
        ylabel('x_1')
        grid on
        grid minor
        legend(leg)
    subplot(212)
        hold on
        cellfun(@(x) plot(x(:,1),x(:,2)), x2_out)
        hold off
        title('Prechodove charakteristiky x_2 pro ruzne poc. podminky')
        xlabel('cas (s)')
        ylabel('x_2')
        grid on
        grid minor
        legend(leg)

figure(2)
    hold on
    cellfun(@(x,y) plot(x(:,2),y(:,2)), x1_out, x2_out)
    hold off
    title('Fazove trajektorie pro ruzne poc. podminky')
    xlabel('x_1')
    ylabel('x_2')
    grid on
    grid minor
    legend(leg)