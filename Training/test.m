clc;
clear all;
% Read in an mp3 file, downsampled to 22 kHz mono
 [d,sr] = mp3read('C:\Users\Yair\Desktop\TEST\Classic\Boccherini - Minuet - Best-of Classical Music.mp3',[1 30*22050],1,2);
 [d1,sr1] = mp3read('C:\Users\Yair\Desktop\TEST\Trance\DUO DJ - ARMIN   TIESTO - THE END OF TRANCE 2012.mp3',[1 30*22050],1,2);
 %[d1,sr1] = mp3read('amclassical_beethoven_fur_elise.mp3',[1 30*22050],1,2);
 %soundsc(d,sr)
 % Convert to MFCCs very close to those genrated by feacalc -sr 22050 -nyq 8000 -dith -hpf -opf htk -delta 0 -plp no -dom cep -com yes -frq mel -filt tri -win 32 -step 16 -cep 20
 [mm,aspc] = melfcc(d*3.3752, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
 [mm1,asp1] = melfcc(d1*3.3752, sr1, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
 % .. then convert the cepstra back to audio (same options)
 [im,ispc] = invmelfcc(mm, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
 [im1,ispc1] = invmelfcc(mm1, sr1, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
 % listen to the reconstruction
 %soundsc(im,sr)
 % compare the spectrograms
 subplot(311)
 specgram(d,512,sr)
 caxis([-50 30])
 title('original music')
 subplot(312)
 specgram(im,512,sr)
 caxis([-40 40])
 title('noise-excited reconstruction from cepstra')
 figure();
 subplot(311)
 specgram(d1,512,sr1)
 caxis([-50 30])
 title('original music1')
 subplot(312)
 specgram(im1,512,sr1)
 caxis([-40 40])
 title('noise-excited reconstruction from cepstra1')
 % Notice how spectral detail is blurred out e.g. the triangle hits around 6 kHz are broadened to a noise bank from 6-8 kHz.
 % save out the reconstruction
  
%   n = NCD ('lzma','best');
%   str1 = mat2str(mm);
%   str2 = mat2str(mm1);
%   
%   result = n.calculate(str1,str2)
mm3 = [mm,mm1];
label = kmedoids(mm3,2);
count = 0;
for i= 1: size(mm,2)
   if label(i) == 2
       label(i)
       count = count+1;
   end
end
if (count/size(mm,2)) > 0.55
    res = 'First belongs to 1'
else
    res = 'First belongs to 2'
end
%spread(mm3,label);

%scatter(mm3,label);
