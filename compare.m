function access = compare( key )
%% Create testing dataset
train1 = key;
filename = 'new_rec.wav'; 
[y,fs] = audioread(filename);
soundsc(y,fs);
cep1 = mfcc(y, fs, 1/25*1000);
diffcep1 = diff(cep1);
diffdiffcep1 = diff(diffcep1);
test(1,:)  = { Pitch_extraction(filename),cep1(1,:), cep1(2,:), cep1(3, :), cep1(4, :), cep1(5, :), cep1(6,:), cep1(7,:),cep1(8,:), cep1(9, :), cep1(10, :), cep1(11, :), cep1(12,:), cep1(13,:), diffcep1(1,:), diffcep1(2,:), diffcep1(3, :), diffcep1(4, :), diffcep1(5, :), diffcep1(6,:), diffcep1(7,:),diffcep1(8,:), diffcep1(9, :), diffcep1(10, :), diffcep1(11, :), diffcep1(12,:), diffdiffcep1(1,:), diffdiffcep1(2,:), diffdiffcep1(3, :), diffdiffcep1(4, :), diffdiffcep1(5, :), diffdiffcep1(6,:), diffdiffcep1(7,:),diffdiffcep1(8,:), diffdiffcep1(9, :), diffdiffcep1(10, :), diffdiffcep1(11, :)};
disp(test);
%% Predict
distance = [];
% I want to test one file at a time now and see if it meets a certain
% threshold that will be the authentication threshold
training_digit_data = cell2mat(train1);
testi = cell2mat(test);
distance(1) = dtw(training_digit_data(1,:),testi);
[whocares, match] = min(distance);
% Now determine whether the match value meets the authentication threshold
% if so, then accept access.
% consider adding another condition to check the individual values in the
% distance array to see if any of those values has an abnormally close
% distance to the user set

if( mean(distance)<875) %after testing, 40 seemed to be a good threshold for authentication
    access = 1;
    disp(distance);

else
    access = 0;
    disp(distance); 
end   

end