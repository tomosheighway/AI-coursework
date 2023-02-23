classdef my_ClassificationKNN < handle
        
    properties
        
        % Note: we stick with the Matlab naming conventions from fitcknn
        
        X % training examples
        Y % training labels
        NumNeighbors % number of nearest neighbours to consider
        ClassNames
        NumClasses

        Verbose % are we printing out debug as we go?
    end
    
    methods
        
        % constructor: implementing the fitting phase
        
        function obj = my_ClassificationKNN(X, Y, NumNeighbors, Verbose)
            
            % set up our training data:
            obj.X = X;
            obj.Y = Y;
            % store the number of nearest neighbours we're using:
            obj.NumNeighbors = NumNeighbors;
            obj.ClassNames = unique(Y);
            obj.NumClasses = length(unique(Y));
            % are we printing out debug as we go?:
            obj.Verbose = Verbose;
        end
        
        % the prediction phase:
        
        function [predictions, scores] = predict(obj, test_examples)
            
            % get ready to store our predicted class labels:
            predictions = categorical;
            num = 0; 
            scores = zeros(length(test_examples),  obj.NumClasses);
            % over to you for the rest... 
            
            % add your code on the lines below...
            
           %old method using knnsearch  
           %for i = 1: length(test_examples)
           %    ind = knnsearch(obj.X, test_examples(i,:),'K', obj.NumNeighbors);
           %     predictions(i,:) = mode(obj.Y(ind));   
           %end
           
           for i = 1: length(test_examples)                     %loop over testing examples 
               distances = zeros(1, length(obj.X));             %array for distances of current test to training  
               
               %use eucilidian distance and store distance in the array distances 
               for j=1:length(obj.X)
                    distance = sqrt( sum((test_examples(i,:) - obj.X(j,:)).^2) );
                    distances(j) = distance;   
               end
                
               [~, ind] = sort(distances);                       %sort the distances array to take NN
               n_neighbors = ind(1:obj.NumNeighbors);

               predictions(i) = mode(obj.Y(n_neighbors));       %predict label 
              
               
               for j = 1:obj.NumClasses                         %loop over and set score values 
                    scores(i, j) = sum(obj.Y(n_neighbors) == obj.ClassNames(j)) / obj.NumNeighbors;
               end
           end
           predictions = transpose(predictions);   %transpose to make it the correct layout
          
        

         
        %loop over test
        %calculate distance between current test and all training 
        
            
            
        end
        
    end
    
end
