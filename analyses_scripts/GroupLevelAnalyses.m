%% Neural correlates of morphosyntactic processing in Spanish-English bilingual children: An fNIRS study
% Authors: Alisa Baron, Neelima Wagley, Xiaosu Hu, Ioulia Kovelman
% OSF Page: https://osf.io/v5hkq/

% This script analyzes data for the above-mentioned
% publication and was originally created by Xiaosu Hu and Neelima Wagley.
% The data anlyses pipeline as listed below uses the NIRS AnalyzIR toolbox
% (Santosa et al., 2018) and individualized scrpits by Hu et al (2010).

% Script 3 of 4
% Last Modified: 02/03/2023 by NW

%% Second-level analyses
%    - Run group-level GLM (include controlls if needed)
%    - Run contrasts on group level data

%% Add path to NIRS toolbox and data analysis folder
% Santosa, H., Zhai, X., Fishburn, F., & Huppert, T. (2018). The NIRS Brain AnalyzIR Toolbox. Algorithms, 11(5), 73.

% locate and add path to the nirs toolbox
nirstoolboxdir = uigetdir();
addpath(genpath(nirstoolboxdir));

% locate and add path to data analysis folder with scripts and data
% analysesdir = uigetdir();
% addpath(genpath(analysesdir));

%% Initialize group-level GLM

grouplevelpipeline  = nirs.modules.MixedEffects();

%% Basic task effects: group (older, younger) by task condition (corr, eds, ing)

grouplevelpipeline.formula = 'beta ~ -1 + group:cond + (1|subject)';
GroupStats1 = grouplevelpipeline.run(SubjStats);

%% Basic task effects: group (older, younger) by task condition (corr, eds, ing)
% CONTROLLING for overall task accuracy

grouplevelpipeline.formula = 'beta ~ -1 + group:cond + synacc + (1|subject)';
GroupStats2 = grouplevelpipeline.run(SubjStats);

%% Basic task effects: continuous, all subjects by task condition (corr, eds, ing)

grouplevelpipeline.formula = 'beta ~ -1 + cond + (1|subject)';
GroupStats3 = grouplevelpipeline.run(SubjStats);

%% Basic task effects: continuous, all subjects by task condition (corr, eds, ing)
% CONTROLLING for age in months

grouplevelpipeline.formula = 'beta ~ -1 + cond + agem + (1|subject)';
GroupStats4 = grouplevelpipeline.run(SubjStats);

%% Plot group stats results from above

% for quick visualization of the results
% can change scale of values plotted within [ ] 
% GroupStats1.draw('tstat',[-6 6]); %for analyses where subjs are grouped by age
% GroupStats2.draw('tstat',[-6 6]); %for analyses where subjs are grouped by age
% GroupStats3.draw('tstat',[-6 6]); %for analyses where subjs are continuous
% GroupStats4.draw('tstat',[-6 6]); %for analyses where subjs are continuous

% to display results in table format
Table1 = GroupStats1.table; %for analyses where subjs are grouped by age
Table2 = GroupStats2.table; %for analyses where subjs are grouped by age
Table3 = GroupStats3.table; %for analyses where subjs are continuous
Table4 = GroupStats4.table; %for analyses where subjs are continuous

% save the analyses output
save('GroupStats.mat','GroupStats3', 'GroupStats4');

%% Analyze conditional contrasts within each age group
% data is called in with the older group first. contrast matrix is old old old young young
% young in the task condition order of corr, eds, ing 

% OLDER group EDS>ING
% define contrast of interest 
c = [0 0 1 0 -1 0 0 0 0] 
 


% compute the contrast specified above using the groupstats defined below
groupstats = GroupStats2;
older_eds_ing_stats = groupstats.ttest(c);
older_eds_ing_results = older_eds_ing_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = older_eds_ing_results.cond(1);

older_eds_ing_hbo = older_eds_ing_results(strcmp(older_eds_ing_results.type,'hbo')&strncmp(older_eds_ing_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OLDER group ING>EDS
% define contrast of interest
c = [0 0 -1 0 1 0 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
older_ing_eds_stats = groupstats.ttest(c);
older_ing_eds_results = older_ing_eds_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = older_ing_eds_results.cond(1)

older_ing_eds_hbo = older_ing_eds_results(strcmp(older_ing_eds_results.type,'hbo')&strncmp(older_ing_eds_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OLDER group EDS>CORR
% define contrast of interest
c = [-1 0 1 0 0 0 0 0 0]  

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
older_eds_corr_stats = groupstats.ttest(c);
older_eds_corr_results = older_eds_corr_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = older_eds_corr_results.cond(1)

older_eds_corr_hbo = older_eds_corr_results(strcmp(older_eds_corr_results.type,'hbo')&strncmp(older_eds_corr_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OLDER group ING>CORR
% define contrast of interest
c = [-1 0 0 0 1 0 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
older_ing_corr_stats = groupstats.ttest(c);
older_ing_corr_results = older_ing_corr_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = older_ing_corr_results.cond(1)

older_ing_corr_hbo = older_ing_corr_results(strcmp(older_ing_corr_results.type,'hbo')&strncmp(older_ing_corr_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUNGER group EDS>ING
% define contrast of interest
c = [0 0 0 1 0 -1 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
young_eds_ing_stats = groupstats.ttest(c);
young_eds_ing_results = young_eds_ing_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = young_eds_ing_results.cond(1)

young_eds_ing_hbo = young_eds_ing_results(strcmp(young_eds_ing_results.type,'hbo')&strncmp(young_eds_ing_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUNGER group ING>EDS
% define contrast of interest
c = [0 0 0 -1 0 1 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
young_ing_eds_stats = groupstats.ttest(c);
young_ing_eds_results = young_ing_eds_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = young_ing_eds_results.cond(1)

young_ing_eds_hbo = young_ing_eds_results(strcmp(young_ing_eds_results.type,'hbo')&strncmp(young_ing_eds_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUNGER group EDS>CORR
% define contrast of interest
c = [0 -1 0 1 0 0 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
young_eds_corr_stats = groupstats.ttest(c);
young_eds_corr_results = young_eds_corr_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = young_eds_corr_results.cond(1)

young_eds_corr_hbo = young_eds_corr_results(strcmp(young_eds_corr_results.type,'hbo')&strncmp(young_eds_corr_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUNGER group ING>CORR
% define contrast of interest
c = [0 -1 0 0 0 1 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
young_ing_corr_stats = groupstats.ttest(c);
young_ing_corr_results = young_ing_corr_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = young_ing_corr_results.cond(1)

young_ing_corr_hbo = young_ing_corr_results(strcmp(young_ing_corr_results.type,'hbo')&strncmp(young_ing_corr_results.cond,contrast,length(contrast)),:);

%% Analyze conditional contrasts between each age group
% data is called in with the older group first. contrast matrix is old old old young young
% young in the task condition order of corr, eds, ing

% OLD - YOUNG contrast for EDS condition
c = [0 0 1 -1 0 0 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
old_young_eds_stats = groupstats.ttest(c);
old_young_eds_results = old_young_eds_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = old_young_eds_results.cond(1)

old_young_eds_hbo = old_young_eds_results(strcmp(old_young_eds_results.type,'hbo')&strncmp(old_young_eds_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUNG - OLD contrast for EDS condition
c = [0 0 -1 1 0 0 0 0 0]

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
young_old_eds_stats = groupstats.ttest(c);
young_old_eds_results = young_old_eds_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = young_old_eds_results.cond(1)

young_old_eds_hbo = young_old_eds_results(strcmp(young_old_eds_results.type,'hbo')&strncmp(young_old_eds_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OLD - YOUNG contrast for ING condition
c = [0 0 0 0 1 -1 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
old_young_ing_stats = groupstats.ttest(c);
old_young_ing_results = old_young_ing_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = old_young_ing_results.cond(1)

old_young_ing_hbo = old_young_ing_results(strcmp(old_young_ing_results.type,'hbo')&strncmp(old_young_ing_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% YOUNG - OLD contrast for ING condition
c = [0 0 0 0 -1 1 0 0 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats2
young_old_ing_stats = groupstats.ttest(c);
young_old_ing_results = young_old_ing_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = young_old_ing_results.cond(1)

young_old_ing_hbo = young_old_ing_results(strcmp(young_old_ing_results.type,'hbo')&strncmp(young_old_ing_results.cond,contrast,length(contrast)),:);

%% Analyze conditional contrasts with effects of age - all participants
% contrast matrix is age, correct, eds, ing

% EDS - ING contrasts for for all participants
c = [0 0 1 -1] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats4
eds_ing_all_stats = groupstats.ttest(c);
eds_ing_all_results = eds_ing_all_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = eds_ing_all_results.cond(1)

eds_ing_all_hbo = eds_ing_all_results(strcmp(eds_ing_all_results.type,'hbo')&strncmp(eds_ing_all_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ING - EDS contrast for for all participants
c = [0 0 -1 1] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats4
ing_eds_all_stats = groupstats.ttest(c);
ing_eds_all_results = ing_eds_all_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = ing_eds_all_results.cond(1)

ing_eds_all_hbo = ing_eds_all_results(strcmp(ing_eds_all_results.type,'hbo')&strncmp(ing_eds_all_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% EDS - Correct contrasts for for all participants
c = [0 -1 1 0] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats4
eds_corr_all_stats = groupstats.ttest(c);
eds_corr_all_results = eds_corr_all_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = eds_corr_all_results.cond(1)

eds_corr_all_hbo = eds_corr_all_results(strcmp(eds_corr_all_results.type,'hbo')&strncmp(eds_corr_all_results.cond,contrast,length(contrast)),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ING - Correct contrast for for all participants
c = [0 -1 0 1] 

% computes the contrast specified above using the groupstats defined below
groupstats = GroupStats4
ing_corr_all_stats = groupstats.ttest(c);
ing_corr_all_results = ing_corr_all_stats.table();

% creating a variable called 'contrast' to define the conditions (contrast of interest) within the nirs toolbox 
contrast = ing_corr_all_results.cond(1)

ing_corr_all_hbo = ing_corr_all_results(strcmp(ing_corr_all_results.type,'hbo')&strncmp(ing_corr_all_results.cond,contrast,length(contrast)),:);

%% SAVE the above contrasts of interest

save('Syntax_Contrasts', 'eds_ing_all_hbo','ing_eds_all_hbo', 'eds_corr_all_hbo', 'ing_corr_all_hbo');

%% END