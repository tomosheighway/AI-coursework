classdef my_ClassificationEnsemble < handle

    properties 
        X % training examples
        Y % training labels
        m_nb        
        m_knn    
        scores
    end

    methods
        function obj = my_ClassificationEnsemble(X, Y)
            obj.X = X;
            obj.Y = Y;
            obj.m_nb = my_fitcnb(X, Y);                         %use my nb 
            obj.m_knn = my_fitcknn(X, Y, 'NumNeighbors', 5);    %use my knn with k 5
           
        end

        function predictions = predict(obj, test_examples)
            predictions = categorical;
            [~, scores_nb] = obj.m_nb.predict(test_examples);         %NB predictions          
            [~, scores_knn] = obj.m_knn.predict(test_examples);       %knn preictions 
            scores_en = (scores_nb + scores_knn) ./ 2;               %score ensemble 
            obj.scores = scores_en;


            %[~, ind] = max(scores_en');
            %predictions = obj.m_nb.ClassNames(ind);

            %had issues with the lines above on the online version of matlab so replaced with a for loop. 
            for i = 1:size(test_examples,1)
                [~, ind] = max(scores_en(i, :)');
                predictions = [predictions ; obj.m_nb.ClassNames(ind)];             
            end

        end
    end
end