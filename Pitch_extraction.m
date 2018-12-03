% pitch extraction
function [pitches] = Pitch_extraction(filename)
[y,fs] = audioread(filename);
[f0_time,f0_value,SHR,f0_candidates]=shrp(y,30000);
[height, pitches] = findpeaks(f0_value, 'MinPeakHeight', max(f0_value)-1);

end