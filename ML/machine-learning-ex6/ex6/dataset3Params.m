function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.1;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

## candidates = [0.01 0.03 0.1 0.3 1 3 10 30]';
## combinations = zeros(length(candidates) ^ 2, 2);
## erros = zeros(length(combinations), 1);

## index = 1;
## for i = 1:length(candidates)
##   for j = 1:length(candidates)
##     model = svmTrain(X, y, candidates(i), @(x1, x2) gaussianKernel(x1, x2, candidates(j)));
##     predictions = svmPredict(model, Xval);
##     error = mean(double(predictions ~= yval));
##     combinations(index, 1) = candidates(i);
##     combinations(index, 2) = candidates(j);
##     errors(index) = error;
##     index += 1;
##   end
## end

## [ignored min_index] = min(errors);
## C = combinations(min_index, 1);
## sigma = combinations(min_index, 2);
% =========================================================================

end
