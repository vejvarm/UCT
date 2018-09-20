clear

Kz = 20;
K2 = 0.02;
Ul = 10;
Un = 25;
T = 2;

w = [1, 1.5, -1];
leg = strings(length(w),2);

e_list = zeros(length(w),61);
de_list = e_list;

size(e_list)

figure(1)
for i = 1:length(w)
    w0 = w(i);
    sim('fazova_trajektorie_2');
%     e_list(i,:) = e.signals.values;
%     de_list(i,:) = de.signals.values;
    plot(e.signals.values,de.signals.values)
    leg(i,:) = ['w = ' num2str(w0)];
    hold on
end
hold off

legend(leg)