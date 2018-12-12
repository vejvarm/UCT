function plot_mis(x,mis,ttl)
    hold on
    cellfun(@(mi) plot(x,mi), mis)
    hold off
    
    title(ttl)
    xlabel('x')
    ylabel('\mu')

