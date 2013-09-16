addpath(genpath('./'));
clear all;
TRAINPATH = 'Data/Train/';
TESTPATH = 'Data/Test/';
filelist = dir([TRAINPATH '*.mfcc']);
UBMcorpus = [];
% construir corpus para entrenar UBM
for i = 1:length(filelist)
    UBMcorpus = [UBMcorpus, load([TRAINPATH filelist(i).name])];
end
nCentres = 16;
covarType = 'diag';
% La inicialización termina con: Maximum number of iterations has been exceeded
UBM = gmm(size(UBMcorpus,1), nCentres,covarType);
UBM = gmminit(UBM, UBMcorpus',foptions());
[UBM, OPTIONS, ERRLOG] = gmmem(UBM, UBMcorpus', foptions());

filelist = dir([TESTPATH '*.mfcc']);
% construir conjunto para segmentos de test y modelos targets
% los números en velocidad normal se utilizan para entrenar modelos target
numTests = 0;
targetset(1).mfcc = []; 
for i = 1:length(filelist)
    if (filelist(i).name(5)~='n')
        numTests = numTests + 1;
        testset(numTests).id = str2num(filelist(i).name(2));
        testset(numTests).mfcc = load([TESTPATH filelist(i).name]);
    else 
        gender = filelist(i).name(3) == 'm';
        nModel = mod(str2num(filelist(i).name(7)),5)+1;
        ID = str2num(filelist(i).name(2));
        index = gender*5+nModel;
        targetset(index).id = ID;
        targetset(index).mfcc = [targetset(index).mfcc, load([TESTPATH filelist(i).name])];
    end
end

%COMPLETAR: adaptar un modelo para cada target, utilizando la función 
% gmmmap con un coeficiente r = 16
for nModel = 1:length(targetset)
    targetset(nModel).gmm = gmmmap(UBM,targetset(nModel).mfcc',16);
end

%COMPLETAR: testear cada modelo target con cada uno de los tests del
% testset y guardar los scores en dos arrays, uno con los targets y otro
% con los nontargets
% Utilizar las funciones gmmprob_ntop y gmmprob_index
targetScores = [];
nontargetScores = [];
for nModel = 1:length(targetset)
    for i = 1:length(testset)
        INDEX = gmmprob_index(UBM,testset(i).mfcc', 16);
        ubmScore = gmmprob_ntop(UBM,INDEX,testset(i).mfcc');
        modelScore = gmmprob_ntop(targetset(nModel).gmm,INDEX,testset(i).mfcc');
        if (targetset(nModel).id == testset(i).id)
            targetScores(end+1) = modelScore - ubmScore;
        else
            nontargetScores(end+1) = modelScore - ubmScore;
        end
    end
end


%COMPLETAR: Graficar la curva DET 
[Pmiss,Pfa] = Compute_DET(targetScores,nontargetScores);
Plot_DET(Pmiss,Pfa,'r');

%COMPLETAR: calcular Cllr y mínimo Cllr
CLLR = cllr(targetScores,nontargetScores)
minCLLR = min_cllr(targetScores,nontargetScores)

%EER: Error en el punto en que Pfa == Pmiss
[val, ind] = min(abs(Pmiss-Pfa));
EER = (Pmiss(ind)+Pfa(ind)) / 2 % El EER es de ~25%
