function [confusionMatrix] = modelsTestParticular()
%=========================================================================
% modelsTest - test recognition of numbers [0-10] using DTW 
% 
% Input parameters: modelsPath - path where are the trained models
%
%
%=========================================================================

folderPath = './test_2/';

k = 7;

testData.groups{1}= 2;
%% testData.groups{2}= 7;
testData.sex = ['f', 'm'];
testData.repets = 3;
testData.speed = ['n', 'f', 's'];

% Initialize a Confusion Matrix
nTotNum = 11;
confusionMatrix = zeros(nTotNum);

for nNum=0:10
     for groupN=1:length(testData.groups)

       for nSpeaker=1:length(testData.groups{groupN})
           for ispeed=1:length(testData.speed);
                  testFileName =  ['s',num2str(testData.groups{groupN}(nSpeaker)),testData.sex(groupN),...
                      num2str(testData.repets),testData.speed(ispeed),'-',num2str(nNum)];
                  waveformTest = load([folderPath,testFileName,'.mfcc']);
                  %~ Hasta aca solo recorrimos y obtuvimos el archivo .mfcc para testear
                  % Sets up an array to keep the likelihood of each model
                  %~ scoreModels = zeros(1,nTotNum);
                  %~ 
                  %~ for nModels=0:10
                      %~ modelPath= [modelsPath, 'ModelTemplate', num2str(nModels),'.mat'];
                      %~ load(modelPath);
                      %~ [D,ch]=dtw(modelTemplate,waveformTest,0);
                      %~ scoreModels(nModels+1) = D;
                  %~ end
                  %~ [val,ind] = min(scoreModels);				 
                  
                  ind = KNNParticular(k, waveformTest, folderPath) + 1;
                   
                  disp(['Sample: ', testFileName, ' Recognized as: ', num2str(ind-1)]);
                  confusionMatrix(nNum+1,ind) = confusionMatrix(nNum+1,ind) + 1;
               end
           end
       end
    end
end

% Conf = modelsTest('./Models/');
