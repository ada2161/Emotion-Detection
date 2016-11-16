%to extract the mfcc features of the testingdata after removing silence
clear all;
clc;
a=dir('emotions_test/*');
%mkdir('mfcc_test');
%mkdir('lpcres_test');
for i=3:length(a)
    disp(i);
    allwav=dir(fullfile('emotions_test',a(i).name,'*.wav'));
    
    for j=1:length(allwav)
        fname=fullfile('emotions_test',a(i).name,allwav(j).name);
        [y,FS]=audioread(fname);
        sig=y.*y;
        E=mean(sig);
        Threshold=0.05*E;
        k=1;
        for b=1:100:(length(sig)-100)
            if((sum(sig(b:b+100)))/100 > Threshold)
                dest(k:k+100)=y(b:b+100);
                k=k+100;
            end;
        end;
        dest=dest';
        clear  FS FFX Threshold E sig y ;
        
        
        
        
        
        %% LP residual extraction
%                 fs = 8000;
%                 lpcord=2+floor(fs/1000);
%                 spp=filter([1 -exp(-2*pi*50/fs)],1,dest);                    % preemphasis zero is at 50 Hz
%                 [lpar,lpe,lpk]=lpcauto(spp,lpcord,floor([0.01 0.02]*fs));  % 20ms frame with 10ms frame increment
%                 overlap=lpk(1,2)-lpk(2,1)+1;                               % overlap between adjacent frames
%                 u=lpcifilt(dest,lpar,lpk(:,1)+floor(overlap/2),0,overlap/4); % do inverse filtering
%                 f=enframe(u,window(@rectwin,2000),50);
%                 AR1 = f(:,1:100:end);
%                 mkdir(fullfile('lpcres_supra_test',a(i).name));
%                 save(fullfile('lpcres_supra_test',a(i).name, regexprep(allwav(j).name, '.wav', '')),'AR1');
        
        
       %% MFCC feature extraction
                 AR2=mfcc_rasta_delta_pkm_v1(dest,8000,13,26,20,10,0,1,1);
                 mkdir(fullfile('mfcc_test',a(i).name));
                 save(fullfile('mfcc_test',a(i).name, regexprep(allwav(j).name, '.wav', '')),'AR2');
        
        %% GVV signal samples
%                 fs = 8000;
%                 p_vt = round(fs/1000+4);    % LPC analysis order
%                 p_gl = round(fs/2000);      % LPC analysis order for the glottal source
%                 x = iaif(dest,fs,p_vt,p_gl,0.99,0);
%                 f=enframe(x,window(@rectwin,160),20);
%                 AR3 = f(:,1:8:end);
%                 mkdir(fullfile('gvv_test',a(i).name));
%                 save(fullfile('gvv_test',a(i).name, regexprep(allwav(j).name, '.wav', '')),'AR3');
        
      %% GVV parameters  
%         fs = 8000;
%         p_vt = round(fs/1000+4);    % LPC analysis order
%         p_gl = round(fs/2000);      % LPC analysis order for the glottal source
%         x = iaif(dest,fs,p_vt,p_gl,0.99,0);
%         for rg=1:length(x)
%             if x(rg) < 0
%                 x(rg) = 0;
%             end
%         end
%         features = [];
%         ind = 1;
%         for rg=2:length(x)
%             if x(rg-1) == 0 && x(rg) > 0
%                 old=rg;
%                 break;
%             end
%         end
%         for rg=old+1:length(x)
%             if x(rg-1) == 0 && x(rg) > 0
%                 features(ind,:) = gvvparam(x(old:rg-1));
%                 old=rg;
%                 ind = ind + 1;
%             end
%         end
%         AR4 = features;
%         mkdir(fullfile('gvvparams_test',a(i).name));
%         save(fullfile('gvvparams_test',a(i).name, regexprep(allwav(j).name, '.wav', '')),'AR4');
% %         
%         clear AR1 AR2 AR3 AR4 dest fname  ;
     end;
end;

