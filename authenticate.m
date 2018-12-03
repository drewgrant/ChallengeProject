function [authentication, distance] = authenticate(files, testfilename)
%% Create training dataset
files = 1; %change this to alter the amount of train/test files 
% testfilename = 'new_rec.wav'; %hardcode the test file
% testfilenum = 4; %hardcode the test file as one of the digit files
num = 1;
for filenum = 1:files
%     filename1 = strcat(num2str(filenum),'pass.wav');
    filename1 = strcat('new_rec.wav');
    [y1,fs] = audioread(filename1);
    soundsc(y1,fs);
    cep = mfcc(y1, fs, 1/25*1000);
    diffcep = diff(cep);
    diffdiffcep = diff(diffcep);
   
%     spectra = Spectrum_extraction(filename1);
%     for i= 1:length(spectra) -1
%         if spectra(i) >mean(spectra)
%             spec1(num) = spectra(i);
%             num = num +1;
%         end 
%     end
%     train1(filenum,:) = {lpc_extraction(filename1), Spectrum_extraction(filename1),Spectrum_extraction2(filename1),  Pitch_extraction(filename1), cep(1,:), cep(2,:), cep(3, :)};
    train1(filenum,:) = {Pitch_extraction(filename1),cep(1,:), cep(2,:), cep(3, :), cep(4, :), cep(5, :), cep(6,:), cep(7,:),cep(8,:), cep(9, :), cep(10, :), cep(11, :), cep(12,:), cep(13,:), diffcep(1,:), diffcep(2,:), diffcep(3, :), diffcep(4, :), diffcep(5, :), diffcep(6,:), diffcep(7,:),diffcep(8,:), diffcep(9, :), diffcep(10, :), diffcep(11, :), diffcep(12,:), diffdiffcep(1,:), diffdiffcep(2,:), diffdiffcep(3, :), diffdiffcep(4, :), diffdiffcep(5, :), diffdiffcep(6,:), diffdiffcep(7,:),diffdiffcep(8,:), diffdiffcep(9, :), diffdiffcep(10, :), diffdiffcep(11, :)};
end
% key = train1;
%% Create testing dataset
%   num = 1;

%     filename = strcat(num2str(testfilenum),'wrong.wav'); %hardcode the
%     test file as one of the digit files
    filename = testfilename; 
    [y,fs] = audioread(filename);
    soundsc(y,fs);
    cep1 = mfcc(y, fs, 1/25*1000);
    diffcep1 = diff(cep1);
    diffdiffcep1 = diff(diffcep1);

%     spectra = Spectrum_extraction(filename); %%%%%its using the passphrase spectrum but this is working best for now.....
%     for i= 1:length(spectra) -1
%         if spectra(i) >mean(spectra)
%             spec(num) = spectra(i); %%could be using some of the values from the previous iteration of spec.....
%             num = num +1;
%         end 
%     end
    
    test(1,:)  = { Pitch_extraction(filename),cep1(1,:), cep1(2,:), cep1(3, :), cep1(4, :), cep1(5, :), cep1(6,:), cep1(7,:),cep1(8,:), cep1(9, :), cep1(10, :), cep1(11, :), cep1(12,:), cep1(13,:), diffcep1(1,:), diffcep1(2,:), diffcep1(3, :), diffcep1(4, :), diffcep1(5, :), diffcep1(6,:), diffcep1(7,:),diffcep1(8,:), diffcep1(9, :), diffcep1(10, :), diffcep1(11, :), diffcep1(12,:), diffdiffcep1(1,:), diffdiffcep1(2,:), diffdiffcep1(3, :), diffdiffcep1(4, :), diffdiffcep1(5, :), diffdiffcep1(6,:), diffdiffcep1(7,:),diffdiffcep1(8,:), diffdiffcep1(9, :), diffdiffcep1(10, :), diffdiffcep1(11, :)};
    disp(test);

%% Predict
distance = [];
match = [];
% I want to test one file at a time now and see if it meets a certain
% threshold that will be the authentication threshold
for training_digit = 1:files
    training_digit_data = cell2mat(train1);
    testi = cell2mat(test);
    distance(training_digit) = dtw(training_digit_data(training_digit,:),testi);

[whocares, match(training_digit)] = min(distance);
end
% Now determine whether the match value meets the authentication threshold
% if so, then accept access.
% consider adding another condition to check the individual values in the
% distance array to see if any of those values has an abnormally close
% distance to the user set

if mean(distance)<850 %after testing, 40 seemed to be a good threshold for authentication
    authentication = 1;
    disp(distance);

else
    authentication = 0;
    disp(distance); 
end  
fileID = fopen('auth_distance.txt','a+');
fprintf(fileID,'MADE AN AUTHENTICATION ATTEMPT*****************\n');
fprintf(fileID,'Distance: %4.2f\n', distance);
fprintf(fileID,'Feature Vector: %d\n', testi);
fprintf(fileID,'Authentication: %d\n', authentication);
fclose(fileID);
% end 