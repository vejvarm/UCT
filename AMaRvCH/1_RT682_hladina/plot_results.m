function plot_results(filename, range)
    
    data = dlmread(filename,'\t',3,1);
    
    data = data(range(1):range(2),:);
    
    figure(1)
        plot(data)
        
plot_results()