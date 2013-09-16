% Los archivos .mfcc y .lab para entrenamiento y testing ya fueron creados en sus respectivas carpetas

% Punto i
% 9 coeficientes
TrainNumbersRecognizer('../punto_2/mfcc-coef-9', 5,7,5);
TestNumbersRecognizer('./Models/HMM_M7-Q5-I5.mat', '../punto_2/mfcc-coef-9/', '../punto_2/log_file_coef_9.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)

% 13 coeficientes
TrainNumbersRecognizer('../punto_2/mfcc-coef-13', 5,7,5);
TestNumbersRecognizer('./Models/HMM_M7-Q5-I5.mat', '../punto_2/mfcc-coef-13/', '../punto_2/log_file_coef_13.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)

% 15 coeficientes
TrainNumbersRecognizer('/home/fran/asr/mfcc-coef-15', 5,7,5);
TestNumbersRecognizer('./Models/HMM_M7-Q5-I5.mat', '../punto_2/mfcc-coef-15/', '../punto_2/log_file_coef_15.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)


% Punto ii y iii

% Entrenamiento
TrainNumbersRecognizer('../punto_2/mfcc-coef-9', 5,4,3);
TrainNumbersRecognizer('../punto_2/mfcc-coef-9', 5,4,5);
TrainNumbersRecognizer('../punto_2/mfcc-coef-9', 5,4,7);
TrainNumbersRecognizer('../punto_2/mfcc-coef-9', 5,8,3);
TrainNumbersRecognizer('../punto_2/mfcc-coef-9', 5,8,5);
TrainNumbersRecognizer('../punto_2/mfcc-coef-9', 5,8,7);


% Testeo
TestNumbersRecognizer('./Models/HMM_M4-Q3-I5.mat', '../punto_2/mfcc-coef-9/test/', '../punto_2/log_1.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)
TestNumbersRecognizer('./Models/HMM_M4-Q5-I5.mat', '../punto_2/mfcc-coef-9/test/', '../punto_2/log_2.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)
TestNumbersRecognizer('./Models/HMM_M4-Q7-I5.mat', '../punto_2/mfcc-coef-9/test/', '../punto_2/log_3.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)
TestNumbersRecognizer('./Models/HMM_M8-Q3-I5.mat', '../punto_2/mfcc-coef-9/test/', '../punto_2/log_4.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)
TestNumbersRecognizer('./Models/HMM_M8-Q5-I5.mat', '../punto_2/mfcc-coef-9/test/', '../punto_2/log_5.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)
TestNumbersRecognizer('./Models/HMM_M8-Q7-I5.mat', '../punto_2/mfcc-coef-9/test/', '../punto_2/log_6.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)

% Punto iv
TrainNumbersRecognizer('../punto_2/mfcc-coef-13/train_velocidad_normal/', 5,4,3)
TestNumbersRecognizer('./Models/HMM_M4-Q3-I5.mat', '../punto_2/mfcc-coef-13/test/', '../punto_2/log_punto_4.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)

% Punto v
TrainNumbersRecognizer('../punto_2/mfcc-coef-13/train/', 5,4,3)
TestNumbersRecognizer('./Models/HMM_M4-Q3-I5.mat', '../punto_2/mfcc-coef-13/test/', '../punto_2/log_punto_5.txt')
[precision, recall, specificity, accuracy] = ClassifierStats(ans)
