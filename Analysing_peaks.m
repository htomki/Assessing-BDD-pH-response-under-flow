clc;
close all;
clear all; 

myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.txt')); %gets all wav files in struct
minimumpotential = [];
rangemin = input('Rough minimum potential to search from ');
rangemax = input('Rough maximum potential to search to ');

for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  myfolder = myFiles(k).folder;
  fullFileName = fullfile(myfolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  
  %here is where stuff happens to each file
  Experiment = readmatrix(fullFileName);

 maxrow = size(Experiment);
  minimumi= 0;
  maxi = 0;
  minimumP= 0;
  maximumP= 0;
  for row = 1:maxrow(1)
      if Experiment(row,1)>rangemin && Experiment(row,1)<rangemax
          
          if Experiment(row,2)< minimumi
              minimumi = Experiment(row,2);
              minimumP = Experiment(row,1);
          end
          
          if Experiment(row,2)> maxi
              maxi = Experiment(row,2);
              maxP = Experiment(row,1);
          end
      end
  end
  minimumpotential(k) = minimumP;
  minimumcurrent(k) = minimumi;
  maximumpotential(k) = maxP;
  maximumcurrent(k) = maxi;
end
minimumpotential
minimumcurrent
maximumpotential
maximumcurrent
peak2peak= maximumpotential-minimumpotential
%average = mean(minimumpotential)
%error = std(minimumpotential)
scatter([ 0.1 1 2 4 6 8 0],peak2peak,'*') %plotting peak to peak as a function of flow rate
xlabel('Flow Rate [ml/min]')
ylabel('Peak to peak seperation [V]')
title('Peak to Peak seperation as a function of flow rate')