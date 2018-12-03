function [recording] = record(time, filename, fs)
%% Record new speech samples
if nargin<3
    fs = 20000; %default sampling frequency
elseif nargin<2
    fs = 20000; %default sampling frequency
    filename = 'new_recording.wav'; %default new filename
end
recorder = audiorecorder(20000,16,1,1);
disp('Start speaking.')
record(recorder);
pause(time);
disp('End of Recording.');
play(recorder);
recording = getaudiodata(recorder);
audiowrite(filename, recording, fs);
end 