function ind = KNN(k, testWave, trainPath )

folderPath = trainPath;

kDistances = inf(1,k);
kNumbers = inf(1,k);

trainingData.groups{1}= 1:6;
trainingData.groups{2}= 1:3;
trainingData.sex = ['m','f'];
trainingData.repets = 3;
trainingData.speed = ['n', 'f', 's'];

super_array = [];
index = 1;

for nNum=0:10
     for groupN=1:length(trainingData.groups)
         for nSpeaker=1:length(trainingData.groups{groupN})
             for ispeed=1:length(trainingData.speed);
                 for nRep=1:trainingData.repets;
                     trainFileName =  ['s',num2str(trainingData.groups{groupN}(nSpeaker)),trainingData.sex(groupN),...
                     num2str(nRep),trainingData.speed(ispeed),'-',num2str(nNum)];
                     waveformTrain = load([folderPath,trainFileName,'.mfcc']);
                     D = dtw(waveformTrain, testWave,  0);
                     [kDistances,kNumbers] = addToKArray(kDistances, kNumbers, D, nNum);
               end
           end
       end
   end
end
ind = mode(kNumbers);
end

function [kDistances,kNumbers] = addToKArray(kDistances, kNumbers, distance, number)
    [maxDist, position] = max(kDistances);
    if (distance >= maxDist)
        return;
    else
        kDistances(position) = distance;
        kNumbers(position) = number;
    end
    return;
 
end
 
