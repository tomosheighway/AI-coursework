% Description: generate a 2D visualisation of the abstraction produced by a
% classifier
%
% Inputs: 
% m: a classifier
% 
% Outputs:
% None
% 
% Notes: 
% You can just assume for now that the classifier has been trained on only
% two predictive features. We'll return to relax this assumption later on.
%
function visualise_abstraction(m)
    train_examples = m.X; 
   
 
    figure; % open a new figure window, ready for plotting
    
    % add your code on the lines below...
    max_size_train = max(train_examples);
    min_size_train = min(train_examples);

    space = (max_size_train - min_size_train) / 100   ;      %1/100 of grids overall width 
    h_space = space(1,1);
    v_space = space(1,2);

    [Xs Ys] = meshgrid(min_size_train(1,1): h_space :max_size_train(1,1), min_size_train(1,2):v_space:max_size_train(1,2));          
    grid_examples = [Xs(1:1:end)' Ys(1:1:end)'];                  
    predictions = m.predict(grid_examples);                       %predictions for the grid examples 
    figure;                                                       % open a new figure window, ready for plotting
    gscatter(grid_examples(:,1), grid_examples(:,2), predictions , 'rgb')
    
        
    
end