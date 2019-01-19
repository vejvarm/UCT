par{1}.ton = 0;

tons = [0 0 1];
toffs = [0 0 -1];
Mons = [1 1 1];
Moffs = [0 -1 -1];

% with relays
for i = 1:length(tons)
    ton = tons(i);
    toff = toffs(i);
    Mon = Mons(i);
    Moff = Moffs(i);
    sim('ekviv_prenos_nelin_1')
    
    figure(i)
    hold on
    plot(w.Time, w.Data)
    plot(y.Time, y.Data)
    hold off
end

% with dead zone
sim('ekviv_prenos_nelin_dead_zone')
figure(length(tons)+1)
hold on
plot(w.Time, w.Data)
plot(y.Time, y.Data)
hold off

% with two relays
sim('ekviv_prenos_nelin_2_relays')
figure(length(tons)+2)
plot(w.Time, w.Data)
hold on
plot(y.Time, y.Data)
hold off

% with two relays, hysteresis and dead zone
sim('ekviv_prenos_nelin_2_relays_hyster')
figure(length(tons)+3)
plot(w.Time, w.Data, y.Time, y.Data)


