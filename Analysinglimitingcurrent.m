clc;
close all;
clear all; 

%need to determine flat region i.e E<value (consistent)
%think average current over E -0.4-> -0.6 
%range to avergage over (must be consistent)
% for -0.6<E<-0.4, average the currents
% don't think we need to smooth as average should correct for random noise


myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.txt')); %gets all wav files in struct
average_lim = [];

for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  myfolder = myFiles(k).folder;
  fullFileName = fullfile(myfolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  
  %here is where stuff happens to each file
  
  Experiment = readmatrix(fullFileName);
  maxrow = size(Experiment);
  
  rangemin=-0.6;
  rangemax=-0.4;
  
  lim_I = [];
  i = 0;
  
  for row = 1:maxrow(1) %going from the start to finish of experimental data
       if Experiment(row,1)>rangemin && Experiment(row,1)<rangemax %if E is between -0.4 and -0.6
           i = i + 1;
           lim_I(i) = Experiment(row,2); %update lim_I to contain current value 
       end
        average_lim(k) = mean(lim_I);   %average these values for limiting current for each file
        error(k) = std(lim_I);
  end
 
end
 average_lim
 average_for_all = mean(average_lim)
 error_for_all = std(average_lim)
 
 %%
hold on
flow_rates = [10 20 30 40 50 60 ];
scatter([10 20 30 40 50 60 ],average_lim,'.') %plotting peak to peak as a function of flow rate
errorbar([10 20 30 40 50 60 ],average_lim, error, 'LineStyle','none');
xlim ([0 62]);
ylim ([-0.000008 0]);
xlabel('Flow Rate [ml/min]')
ylabel('Limiting current')
title('Limiting current as a function of flow rate')

fitrange= 0:0.1:60
fit_third = -(1.728*10.^(-6))* fitrange.^(1/3)
fit_half = -(9.209*10.^-7) * fitrange.^(1/2)
plot(fitrange,fit_third)
plot(fitrange,fit_half)
% General model:
%      f(x) = a*x^(1/3)
% Coefficients (with 95% confidence bounds):
%        a =  -1.728e-06  (-1.869e-06, -1.588e-06)
% 
% Goodness of fit:
%   SSE: 6.221e-20
%   R-square: 0.8879
%   Adjusted R-square: 0.8879
%   RMSE: 1.115e-10

      

% General model:
%      f(x) = a*x^(1/2)
% Coefficients (with 95% confidence bounds):
%        a =  -9.209e-07  (-9.553e-07, -8.866e-07)
% 
% Goodness of fit:
%   SSE: 1.307e-20
%   R-square: 0.9764
%   Adjusted R-square: 0.9764
%   RMSE: 5.114e-11
%   
