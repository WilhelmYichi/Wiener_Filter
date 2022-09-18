clear all

wavDataPath = 'G:\Masterearbeit\0_final_models\0_final\Wiener Filter\Wiener Filter\noisy\';
wavDataDir  = dir([wavDataPath '\*.wav']);
wavDataPath_out = 'G:\Masterearbeit\0_final_models\0_final\Wiener Filter\Wiener Filter\denoised\';

for i = 1:length(wavDataDir)
    [noise,fs] = audioread([wavDataPath wavDataDir(i).name]);
    denoised = wiener_as(noise, fs);
    %denoised = denoised/max(abs(denoised));
    if size(denoised,1)==1
        denoised = denoised';
    end
    len_n = length(noise);
    len_d = length(denoised);
    if len_n ~= len_d
        if len_n > len_d
            len_zero = len_n-len_d;
            denoised = [denoised;zeros(len_zero,1)];
        else
            denoised = denoised(1:len_n);
        end
    end
    audiowrite([wavDataPath_out wavDataDir(i).name(1:end-4) '_denoised_oriset.wav'],denoised,16e3)
end

