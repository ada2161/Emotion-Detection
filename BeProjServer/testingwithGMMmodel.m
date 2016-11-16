%% Testing with GMM modelling
clear all;
clc;
a=dir('allcleanmodels_16_gvvparams/*.mat');
b=dir('mfcc_test');
confmat=zeros(length(a));
d1 = [];
for i=3:length(b)
    
    c=dir(fullfile('mfcc_test',b(i).name,'*.mat'));
    for j=1:length(c)
        load(fullfile('mfcc_test',b(i).name,c(j).name));
        d=zeros(length(a),1);
        for k=1:length(a)
            load(fullfile('allcleanmodels_16_gvvparams',a(k).name));
            m =(gmmprob(MIX,AR2));
            d(k) = mean(log(m));
            e(k) = mean(m);
            
            clear MIX;
        end;
        d=d';
        prob=zeros(length(a),1);
        for k = 1:length(a)
            prob(k) = e(k)/sum(e)*100;
        end
        
        d1 = horzcat(d1,d');
        save(fullfile('gvvparams'),'d1');
        ak=find(d==max(d));
        confmat(i-2,ak)=confmat(i-2,ak)+1;
        clear d y1;
    end;    
end;


sum=0;
for g=1:length(a)
    for h=1:length(b)
        if(g==h)
            sum=sum+confmat(g,h);
        end;
    end;
end;

percentage=(sum/(20*length(a)))*100;

f = fopen('filename.txt', 'w');
[val, indx]=max(prob);
if(indx==1)
    disp('anger');
    fprintf(f,'angry');
    elseif(indx==2)
    disp('fear');
    fprintf(f,'scared');
    elseif(indx==3)
    disp('happy');
    fprintf(f,'happy');
    elseif(indx==4)
    disp('sad'); 
    fprintf(f,'sad');    
end
fclose(f);