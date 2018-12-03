function key = register()
    %% Create training dataset
filename1 = strcat('new_rec.wav');
[y1,fs] = audioread(filename1);
soundsc(y1,fs);
cep = mfcc(y1, fs, 1/25*1000);
diffcep = diff(cep);
diffdiffcep = diff(diffcep);
train1(1,:) = {Pitch_extraction(filename1),cep(1,:), cep(2,:), cep(3, :), cep(4, :), cep(5, :), cep(6,:), cep(7,:),cep(8,:), cep(9, :), cep(10, :), cep(11, :), cep(12,:), cep(13,:), diffcep(1,:), diffcep(2,:), diffcep(3, :), diffcep(4, :), diffcep(5, :), diffcep(6,:), diffcep(7,:),diffcep(8,:), diffcep(9, :), diffcep(10, :), diffcep(11, :), diffcep(12,:), diffdiffcep(1,:), diffdiffcep(2,:), diffdiffcep(3, :), diffdiffcep(4, :), diffdiffcep(5, :), diffdiffcep(6,:), diffdiffcep(7,:),diffdiffcep(8,:), diffdiffcep(9, :), diffdiffcep(10, :), diffdiffcep(11, :)};
key = train1;
end