figure(2)
g = gca;
gch = g.Children;

N = length(gch);

w.t = 0;
w.y = 0;
u.t = 0;
u.y = 0;
y.t = 0;
y.y = 0;

for i = 1:length(gch)
    l = gch(i);
    if l.Marker == 'x' & l.Color == [0 0 1]
%         l.Marker = '.';
%         l.Color = [0.3,0.5,0.2];
        u.t = [l.XData ; u.t];
        u.y = [l.YData ; u.y];
    elseif l.Marker == 'o'
%         l.Marker = 'v';
%         l.Color = 'b'
        y.t = [l.XData ; y.t];
        y.y = [l.YData ; y.y];
    elseif l.Marker == 'x'
%         l.Marker = '+';
%         l.Color = 'r'
        w.t = [l.XData ; w.t];
        w.y = [l.YData ; w.y];
    end
end

% % odstranìní nul na konci
u.t = u.t(1:end-1);
u.y = u.y(1:end-1);
w.t = w.t(1:end-1);
w.y = w.y(1:end-1);
y.t = y.t(1:end-1);
y.y = y.y(1:end-1);

%%
figure(2)
    set(2,'DefaultlineLineWidth',2)
    plot(w.t,w.y,'-r',y.t,y.y,'-b')
    hold on
    stem(u.t,u.y,'.','Color',[0.3,0.5,0.2],'LineStyle','none')
    hold off
    axis tight
    xlabel('èas (s)')
    ylabel('y,w,u (V)')
    grid on
    grid minor
    legend('y','w','u')
    title('Regulace umìlé poruchy')
    
%%
% export_fig(2,'./obrazky/final2a.pdf')