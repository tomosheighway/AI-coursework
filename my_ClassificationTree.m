classdef my_ClassificationTree < handle
    
    properties
        
        % Note: we stick with the Matlab naming conventions from fitctree
        
        X % training examples
        Y % training labels
        MinParentSize % minimum parent node size
        MaxNumSplits % maximum number of splits
        
        Verbose % are we printing out debug as we go?
        
        % add any other properties you want on the lines below...
        ClassNames
        
        
    end
    
    methods
        
        
        
        function obj = my_ClassificationTree(X, Y, MinParentSize, MaxNumSplits, Verbose)
            
            % set up our training data:
            obj.X = X;
            obj.Y = Y;
            % store the minimum parent node size we're using:
            obj.MinParentSize = MinParentSize;
            % store the maximum number of splits we're using:
            obj.MaxNumSplits = MaxNumSplits;
            
            % are we printing out debug as we go?:
            obj.Verbose = Verbose;
            
            % over to you for the rest... 
            
            % add your code on the lines below...
            
            obj.ClassNames = unique(Y);


            obj.tree = obj.train(X,Y)  %train 
            % (note: a function has also been provided on Moodle to
            % calculate weighted impurity given any set of labels)
            
        end


        % GDI function provided but have moved the fucntion here for simplicity  
        function wGDI = weightedGDI(these_labels, train_labels)
            
                % find the number of training labels in the overall problem:
                total_training_labels = size(train_labels,1);
                % find the unique class labels in the overall problem:
                unique_classes = unique(train_labels);
            
                % find the weighting for this particular set of labels:
                weighting = length(these_labels) / total_training_labels;
            
                % find the GDI score for this particular set of labels:
                
                % a summation, starting at zero:
                summ = 0;
                % find the total number of labels we're calculating GDI for:
                total_labels = length(these_labels);
                % compute each term in the summation:
                for i=1:length(unique_classes)
                    
                    % compute, and add to our summation, the contribution for this
                    % class (the fraction of labels that match this class, squared):
                    
                    % the fraction:
                    pc = length(these_labels(these_labels==unique_classes(i))) / total_labels;
                    
                    % the squaring and adding:
                    summ = summ + (pc*pc);
            
                end
                % final part of the GDI calculation:
                g = 1 - summ;
            
                % apply the weighting to the resulting GDI score:
                wGDI = weighting * g;
        end

        
        % the prediction phase:
        
        
        % add any other methods you want on the lines below...
        
        %------code is not complete and doesnt work------

        function prediction = predict(obj, test_examples)

            prediction = zeros(size(test_examples, 1), 1);


            for i = 1:size(test_examples, 1)
                
                current_node = obj.tree;
                node_index = 1

                while ~current_node.leaf
                    if test_examples(i, current_node.feature) < current_node 
                        current_node = current_node.left;
                    else
                        current_node = current_node.right;
                    end
                end
                prediction(i) = current_node.label;
            end
        end


        


        %--- not working ---
        function tree = train( features,  labels )
            
            tree = struct('feature', [], 'value', [], 'left', [], 'right', []);
    
           
            b_gdi = 0;

            for i = 1:size(features, 2)     %loop over all 
                for j = 1:size(features, 1) 
                    l_labels = labels(features(:, i) <= features(j, i));                %left
                    r_labels = labels(features(:, i) > features(j, i));                 %right 
                    gdi = weightedGDI(l_labels, labels) + weightedGDI(r_labels, labels);
                    

                    %check gdi values for best 
                    if gdi > b_gdi          
                        b_gdi = gdi;
                        b_feature = i;
                        b_value = features(j, i);
                    end
                end
            end
    
            %data splitting 
            tree.feature = b_feature;
            tree.value = b_value;
            tree.left = train(features(features(:, b_feature) <= b_value, :), labels(features(:, b_feature) <= b_value));
            tree.right = train(features(features(:, b_feature) > b_value, :), labels(features(:, b_feature) > b_value));
        end



        
        
        %{
        
        %----previous work trying to create a predict function which also does
        %not work---- 

        function predictions = predict(obj, test_examples)
            
            % get ready to store our predicted class labels:
            
            %N_size = size(test_examples ,1 );
            
            predictions = categorical;
            

            % over to you for the rest... 
            
            % add your code on the lines below...
            
            for i = 1:1:size(test_examples,1)
                
                node = obj.tree

                predictions(i, :) = obj.ClassNames; 
            end 
            

            while(m_dt.Children(node_index,1) ~= 0)  % still has children
            
                cpi = m_dt.CutPredictorIndex(node_index); cmp = 0;
                if (cpi ~= 0)
                     cmp = this_test_example(cpi);
    
                    if (cmp < m_dt.CutPoint(node_index))
                        node_index = m_dt.Children(node_index, 1);
                                                                    %left
                    elseif (cmp >= m_dt.CutPoint(node_index))
                         node_index = m_dt.Children(node_index, 2); %right
                    end
                end
            end
            prediction = m_dt.NodeClass(node_index)
            
            
        end
        
        %}
        
    end
    
end