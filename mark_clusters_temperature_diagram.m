% MARK CLUSTERS IN TEMPERATURE DIAGRAM

function mark_clusters_temperature_diagram(handles,tree,clustering_results)

handles.par.min.clus = clustering_results(1,5);
temperature = tree(clustering_results(1,1)+1,2);

% creates cluster-temperature vector to plot in the temperature diagram
nclasses = max(clustering_results(:,2));
for i=1:nclasses
    ind = find(clustering_results(:,2)==i);
    classgui_plot(i) = clustering_results(ind(1),2);
    class_plot(i) = clustering_results(ind(1),4);  
    temp_plot(i) = clustering_results(ind(1),3);  
end


colors = ['b' 'r' 'g' 'c' 'm' 'y' 'b' 'r' 'g' 'c' 'm' 'y' 'b' 'k' 'b' 'r' 'g' 'c' 'm' 'y' 'b' 'r' 'g' 'c' 'm' 'y' 'b' 'k' 'b' 'r' 'g' 'c' 'm' 'y' 'b' 'r' 'g' 'c' 'm' 'y' 'b'];
% draw temperature diagram and mark clusters 
hold(handles.temperature_plot, 'off');
switch handles.par.temp_plot
    case 'lin'
        % draw diagram
        plot(handles.temperature_plot, [handles.par.mintemp handles.par.maxtemp-handles.par.tempstep],[handles.par.min.clus2 handles.par.min.clus2],'k:',...
            handles.par.mintemp+(1:handles.par.num_temp)*handles.par.tempstep, ...
            tree(1:handles.par.num_temp,5:size(tree,2)),[temperature temperature],[1 tree(1,5)],'k:')
        % mark clusters
        hold(handles.temperature_plot, 'on');
        for i=1:length(class_plot)
            tree_clus = tree(temp_plot(i),4+class_plot(i));
            tree_temp = tree(temp_plot(i)+1,2);
            plot(handles.temperature_plot, tree_temp,tree_clus,'.','color',num2str(colors(classgui_plot(i))),'MarkerSize',20);
            % text(tree_temp,tree_clus,num2str(classgui_plot(i)));
        end
        set(get(gca,'ylabel'),'vertical','Baseline');
    case 'log'
        % draw diagram
        set(handles.temperature_plot,'yscale','log');
         semilogy(handles.temperature_plot, [handles.par.mintemp handles.par.maxtemp-handles.par.tempstep], ...
            [handles.par.min.clus handles.par.min.clus],'k:',...
            handles.par.mintemp+(1:handles.par.num_temp)*handles.par.tempstep, ...
            tree(1:handles.par.num_temp,5:size(tree,2)),[temperature temperature],[1 tree(1,5)],'k:')
        % mark clusters
        hold(handles.temperature_plot, 'on');
        for i=1:length(class_plot)
            tree_clus = tree(temp_plot(i),4+class_plot(i));
            tree_temp = tree(temp_plot(i)+1,2);
            semilogy(handles.temperature_plot, tree_temp,tree_clus,'.','color',num2str(colors(classgui_plot(i))),'MarkerSize',20);
            % text(tree_temp,tree_clus,num2str(classgui_plot(i)));
        end
        set(get(handles.temperature_plot,'ylabel'),'vertical','Cap');
end
xlim(handles.temperature_plot, [0 handles.par.maxtemp])
xlabel(handles.temperature_plot, 'Temperature'); 
ylabel(handles.temperature_plot, 'Clusters size');



