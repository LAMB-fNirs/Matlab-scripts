%% Neural correlates of morphosyntactic processing in Spanish-English bilingual children: An fNIRS study
% Authors: Alisa Baron, Neelima Wagley, Xiaosu Hu, Ioulia Kovelman
% OSF Page: https://osf.io/v5hkq/

% This script analyzes data for the above-mentioned
% publication and was originally created by Xiaosu Hu and Neelima Wagley.
% The data anlyses pipeline as listed below uses the NIRS AnalyzIR toolbox
% (Santosa et al., 2018) and individualized scrpits by Hu et al (2010).

% Script 2 of 4
% Last Modified: 02/03/2023 by NW

%% Preprocessing & first-level analyses
%    - Load data
%    - Clean data (remove unecessary stim marks)
%    - Define analyses parameters (e.g. sampling freq, baseline trim)
%    - First-level GLM
%    - Load subjet demographics information
%    - Extract subject-level data for secondary analyses

%% Add path to NIRS toolbox and data analysis folder
% Santosa, H., Zhai, X., Fishburn, F., & Huppert, T. (2018). The NIRS Brain AnalyzIR Toolbox. Algorithms, 11(5), 73.

% locate and add path to the nirs toolbox
nirstoolboxdir = uigetdir();
addpath(genpath(nirstoolboxdir));

% locate and add path to data analysis folder with scripts and data
analysesdir = uigetdir();
addpath(genpath(analysesdir));

%% Define data directory and load dataset
% NOTE: 'Subject' as defined by the analyses toolbox DOES NOT match actual subject number assigned to participant during data collection

% locate and call in the 'data' folder with inidividual participant folders
datadir = uigetdir();

% load in dataset. choose load in type based on group or no group data

% dataset should be structured to load in as group then subject folders
% when analyzing WITH old and young groups
%raw = nirs.io.loadDirectory(datadir,{'group','subject'});

% dataset should be structured to load in all subject folders
% when analyzing WITHOUT groups
raw = nirs.io.loadDirectory(datadir,{'subject'});


disp('All .nirs files loaded!')
disp('-----------------------')

%% Remove extra stim marks (eprime programming error)
% The following loop ONLY applies for the syntax data
% Removes the stim triggers with duration longer than .14 or .16

for i = 1:length(raw)
    for j = 1:length(raw(i).stimulus.keys)
        count = 1;
        ind = [];
        for k = 1:length(raw(i).stimulus.values{j}.dur)
            % Get the duration longer than .5
            if round(raw(i).stimulus.values{j}.dur(k),2)~=0.14 && round(raw(i).stimulus.values{j}.dur(k),2)~=0.16
               %raw(i).stimulus.values{j}.dur(k) > .2||raw(i).stimulus.values{j}.dur(k) < .05
                ind(count) = k;
                count = count + 1;
                % disp(count)
            end
        end
        v = raw(i).stimulus.values;
        v{j}.dur(ind)= [];
        v{j}.onset(ind) = [];
        v{j}.amp(ind) = [];
        raw(i).stimulus.values = v;
        % raw(i).stimulus.values{j}.dur(1) = [];
        % raw(i).stimulus.values{j}.onset(1) = [];
        % raw(i).stimulus.values{j}.amp(1) = [];
    end
end

%% Check the total number of stims for each condition, per participant
% For each sentence task, should have close to 20 trials per condition 

for i = 1:length(raw)
    try
        stimnum(i,1)=length(raw(i).stimulus.values{1}.dur);
        stimnum(i,2)=length(raw(i).stimulus.values{2}.dur);
        stimnum(i,3)=length(raw(i).stimulus.values{3}.dur);
    catch
        i=i+1;
    end
end

%% Select channels for anaysis, remove other channels not used in current study
% index of channels to remove, both hemispheres, both oxy & deoxy
% see document probe_channel_match.xlsx

ch_indx = [11,12,15,16,19,20,23:92]; % onyl LH select 8 channels over frontal and temporal based on preregistration

for i = 1:length(raw)
    raw(i).data(:,ch_indx) = [];  % channels are columns 
    raw(i).probe.link(ch_indx,:) = []; % channels are rows 
end

%% Define parameters for HRF convolution

onsetshift = 0; % shift the onset of the stim marks
trialdur = 4.9; % define the duration of trial 

for i=1:length(raw)
    for j=1:length(raw(i).stimulus.keys)
        v = raw(i).stimulus.values;
        v{j}.onset = v{j}.onset+repmat(onsetshift,size(raw(i).stimulus.values{j}.onset,1),1);
        v{j}.dur = repmat(trialdur,size(raw(i).stimulus.values{j}.dur,1),1);
        raw(i).stimulus.values = v;
        % raw(i).stimulus.values{j}.onset= raw(i).stimulus.values{j}.onset+repmat(onsetshift,size(raw(i).stimulus.values{j}.onset,1),1);
        % raw(i).stimulus.values{j}.dur=repmat(trialdur,size(raw(i).stimulus.values{j}.dur,1),1);
    end
end

%% Plot raw un-processed data (for checking purposed only)
disp(raw(1).time)
raw(1).draw

%% Initialize first-level GLM 

% downsample data from 50Hz to 2 Hz
disp('Running data resample...')
resample = nirs.modules.Resample();
resample.Fs = 2;
downraw = resample.run(raw);

% convert raw data to optical density
disp('Converting Optical Density...')
odconv = nirs.modules.OpticalDensity();
od = odconv.run(downraw);

% apply Beer Lambert Law
disp('Applying Modified Beer Lambert Law...')
mbll = nirs.modules.BeerLambertLaw();
hb = mbll.run(od);

% trim pre and post NIRS file baseline
 disp('Trimming .nirs files...')
 trim = nirs.modules.TrimBaseline();
  trim.preBaseline = 5; % 5 second of data
  trim.postBaseline = 5; % 5 seconds of data
  hb_trim = trim.run(hb);

disp('Processing complete!')
disp('-----------------------')


disp(length(hb))

%% Check numerical order of subject files

for i=1:length(hb)
    disp(num2str(i))
    disp(hb(i).description)
end

%% Run first-level GLM 

disp('Now running subject-level GLM')

% standard GLM basis function
firstlevelglm = nirs.modules.AR_IRLS();
firstlevelbasis = nirs.design.basis.Canonical();

% HRF peak time = 6s based on developmental literature
firstlevelbasis.peakTime = 6; % 6 seconds
firstlevelglm.basis('default') = firstlevelbasis;

SubjStats = firstlevelglm.run(hb_trim);
disp('Done!')

%% Add participant demographics/behavioral score information to SubjStats
% outside of matlab, create an excel sheet with relevant participant
% information to be called into pipeline for analysis. save this file in
% the data analysis folder (not the data folder)

% load participant demographic information
demo = nirs.modules.AddDemographics();

% restoredefaultpath 
demo.demoTable = readtable('<Path_to_Demographics_file>'); 
demo.varToMatch = 'subject'; %this will match the info in the excel with the ids based on the subject FOLDER, not the .nirs file

% add path to NIRS Toolbox here again since we removed it above earlier
% nirstoolboxdir = uigetdir();
% addpath(genpath(nirstoolboxdir));

% add demographics info to SubjStats
SubjStats = demo.run(SubjStats);
%SubjStats = SubjStats';

% check the demopgraphic information loaded correctly
disp(nirs.createDemographicsTable(SubjStats));

%% Save analysis up to this point

% this will only save the 'SubjStats' variable 
save('SubjStats', 'SubjStats');

%% Extracting subject level data for analyses outside of NIRS Toolbox

Syntax_HbO_Cond1 = [];
Syntax_HbO_Cond2 = [];
Syntax_HbO_Cond3 = [];

for i = 1:length(SubjStats)
    
    Subject_Result = SubjStats(i).table;
    
    Cond1_Sub = [cell2table(repmat({SubjStats(i).description(end-17:end-5)},size(SubjStats(i).variables,1)/6,1),'VariableNames',{'Subject'}) ...
        Subject_Result(strcmp(Subject_Result.type,'hbo')&strncmp(Subject_Result.cond,'stim_channel1',length('stim_channel1')),:)];
    [ Cond1_Sub ] = Table_ch_organization(  Cond1_Sub);
    
    Cond2_Sub = [cell2table(repmat({SubjStats(i).description(end-17:end-5)},size(SubjStats(i).variables,1)/6,1),'VariableNames',{'Subject'}) ...
        Subject_Result(strcmp(Subject_Result.type,'hbo')&strncmp(Subject_Result.cond,'stim_channel2',length('stim_channel2')),:)];
    [ Cond2_Sub ] = Table_ch_organization(  Cond2_Sub);
    
    Cond3_Sub = [cell2table(repmat({SubjStats(i).description(end-17:end-5)},size(SubjStats(i).variables,1)/6,1),'VariableNames',{'Subject'}) ...
        Subject_Result(strcmp(Subject_Result.type,'hbo')&strncmp(Subject_Result.cond,'stim_channel3',length('stim_channel3')),:)];
    [ Cond3_Sub  ] = Table_ch_organization( Cond3_Sub);
    
    Syntax_HbO_Cond1 = [Syntax_HbO_Cond1; Cond1_Sub];
    Syntax_HbO_Cond2 = [Syntax_HbO_Cond2; Cond2_Sub];
    Syntax_HbO_Cond3 = [Syntax_HbO_Cond3; Cond3_Sub];
    
    Syntax_HbO_SubjectBeta = [Syntax_HbO_Cond1; Syntax_HbO_Cond2; Syntax_HbO_Cond3];
end

save('SubjStatsTable_HBO','Syntax_HbO_SubjectBeta');

%% END
