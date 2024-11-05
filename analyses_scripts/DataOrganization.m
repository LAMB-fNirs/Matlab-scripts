%% Neural correlates of morphosyntactic processing in Spanish-English bilingual children: An fNIRS study
% Authors: Alisa Baron, Neelima Wagley, Xiaosu Hu, Ioulia Kovelman
% OSF Page: https://osf.io/v5hkq/

% This script analyzes data for the above-mentioned
% publication and was originally created by Xiaosu Hu and Neelima Wagley.
% The data anlyses pipeline as listed below uses the NIRS AnalyzIR toolbox
% (Santosa et al., 2018) and individualized scrpits by Hu et al (2010).

% Script 1 of 4
% Last Modified: 02/03/2023 by NW

%% Data file organization in preparation for preprocessing

%% Add path to NIRS toolbox and data analysis folder
% Santosa, H., Zhai, X., Fishburn, F., & Huppert, T. (2018). The NIRS Brain AnalyzIR Toolbox. Algorithms, 11(5), 73.

% locate and add path to the nirs toolbox
nirstoolboxdir = uigetdir();
addpath(genpath(nirstoolboxdir));

% locate and add path to data analysis folder with scripts and data
analysesdir = uigetdir();
addpath(genpath(analysesdir));

%% Generate the 's' (stim marks) variable by loading the .nirs aux variable for each nirs file
% the following code is specific to the syntax experimental task 

% before running the code, make sure to be within 'data' folder so that participant
% folders end up in the 'data' folder and not in the general folder

% directory = uigetdir; % Select a directory
% file = dir(fullfile(directory, '*.nirs'));

file = uigetfile('*.*','Multiselect','on');

for i=1:length(file)
    clearvars -except i file
    load(file{i},'-mat');
    s = aux(:,2:4); % syntax task = 3 conditions, select columns 2:4 and column 1 = rest triggers
    s(s>1) = 1;
    s(s<1) = 0;
    
    save(file{i},'aux','d','dStd','ml','s','SD','systemInfo','t','tdml');
    disp(strcat(file{i},' completed.....'));
end 

%% Plot 's' variable to check for inconsistencies across participants

% navigate to within the 'data' folder before selecting nirs files to plot
file = uigetfile('*.*','Multiselect','on');

for i = 1:length(file)
    subplot(10,2,i); % this (10,2,i) allows you to plot up to 20 participants' stim marks (10x2 array)
    load(file{i},'-mat');
    plot(t,s);
    title(strcat(file(i)));
end

%% Copy individual .nirs files into sequential 'subject' folders 

% before running the code, make sure to be within 'data' folder so that participant
% folders end up in the 'data' folder and not in the general folderr

startnum = 100; % subject folder starting number 

file = uigetfile('*.*','Multiselect','on');

for i=1:length(file)
    mkdir(strcat('Subject',num2str(i-1+startnum)));
    movefile(file{i},strcat('Subject',num2str(i-1+startnum)));
end

%% END