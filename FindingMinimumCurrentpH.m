clc;
close all;
clear all; 

%%THIS IS FOR ANALYSING PEAKS FOR pH

myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.txt')); %gets all wav files in struct
potentialatminimum = [];
rangemin = input('Rough minimum potential to search from ');
rangemax = input('Rough maximum potential to search to ');

filecounter = 0; %need a variable to count the number of files
num = 1;

for k = 1:length(myFiles)
    
   
  baseFileName = myFiles(k).name;
  myfolder = myFiles(k).folder;
  fullFileName = fullfile(myfolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName); 
  
 if strfind(baseFileName, '(') %incluse this to get rid of first scan (pH)
  %here is where stuff happens to each file
  Experiment = readmatrix(fullFileName);

Dimensions = size(Experiment); %gives dimensions of files
  minimumi= 100000; %gives suitably high/low values of max/min to compare to as starting point
  maxi = -100000; %i.e the first value will always be higher or lower
  minimumP= 10000;
  maximumP= -100000;

 
  %%
  for row = 1:Dimensions(1) %for all the data in the file
      if Experiment(row,1)>rangemin && Experiment(row,1)<rangemax %Go through the potentials in this range
          
          if Experiment(row,2)< minimumi %if the current is a minimum 
              minimumi = Experiment(row,2); %update the minimumi
              minimumP = Experiment(row,1); %stores the potential this minimum occurs at
          end
        
      end
  end
  potentialatminimum(k) = minimumP;% creates a vector full of the potential at peak position for each file
  minimumcurrent(k) = minimumi; %creats a vector full of the peak
  
    %%
  filecounter = filecounter+1;
  if filecounter == length(myFiles)
      potentialaverage(num) =mean(potentialatminimum)
      STDpotentialaverage(num) =std(potentialatminimum)
      num = num + 1;
      filecounter = 0;
      %Averages over the files
  end
     end
end
%%
potentialatminimum
averageminimumpotential = mean(potentialatminimum)
errorminimumpotential = std(potentialatminimum)

% xrange = 1:length(myFiles)
% scatter(xrange,potentialatminimum, 200,'.') %plotting the 
% xlabel('Cycle Number')
% ylabel('pH response peak [mV]')
% ylim([0.06 0.08])

% hold on
% flowrate=[ 0 0.1 1 2 4 6 8 10 20 40 60]
% flowratelegend = ['Stationary' '0.1ml/min' '1ml/min' '2ml/min' '4ml/min' '6ml/min' '8ml/min' '10ml/min' '20ml/min' '40ml/min' '60ml/min']
% scatter(flowrate,flowaverage,200,'.','k')
% errorbar(flowrate,flowaverage, STDflowaverage,'LineStyle','none')
% xlabel('Flow Rate [ml/min]')
% ylabel('pH response peak [V]')
% xlim([-5 70])
% ylim([0.3 0.5])
% title('Position of 2.01 pH peak at different flowrate')
