clear
close all

% system parameters
Kz = 20;
K2 = 0.02;
Ul = 10;
Un = 25;
T = 2;

% desired w's
w = [1, 1.5, -1];

% initialize containers
leg = strings(length(w),1);
es = cell(1, length(w));
des = es;
step_resp.times = es;
step_resp.values = es;


% run simulation and save results to containers
for i = 1:length(w)
    w0 = w(i);
    sim('fazova_trajektorie');
    es{i} = e.signals.values;
    des{i} = de.signals.values;
    step_resp.times{i} = y.time;
    step_resp.values{i} =  y.signals.values;
    leg(i) = ['w = ' num2str(w0)];
end
hold off

figure(1)
    plot_results(es, des, 'Fázová trajektorie odchylky', 'e', 'de', leg)
    
figure(2)
    plot_results(step_resp.times, step_resp.values, ...
                 'Prechodová charakteristika', 't', 'y', leg)
    
function plot_results(x, y, ttl, xlab, ylab, leg)
    hold on
    cellfun(@plot, x, y)
    hold off
    title(ttl)
    xlabel(xlab)
    ylabel(ylab)
    legend(leg)
    grid on
end