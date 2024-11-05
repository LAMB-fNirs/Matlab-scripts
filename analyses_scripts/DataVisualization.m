%% Neural correlates of morphosyntactic processing in Spanish-English bilingual children: An fNIRS study
% Authors: Alisa Baron, Neelima Wagley, Xiaosu Hu, Ioulia Kovelman
% OSF Page: https://osf.io/v5hkq/

% This script analyzes data for the above-mentioned
% publication and was originally created by Xiaosu Hu and Neelima Wagley.
% The data anlyses pipeline as listed below uses the NIRS AnalyzIR toolbox
% (Santosa et al., 2018) and individualized scrpits by Hu et al (2010).

% Script 4 of 4
% Last Modified: 02/03/2023 by NW

%% GLM Second (group) Level Analyses 
% Data analyses pipile as listed below using Huppert et al NIRS Toolbox and
% inidividualized scripts created by Frank Hu. 

% 4. Create 3D Brain Plots

%% Data vidualization on a 3D brain template

%% Add path to NIRS toolbox and data analysis folder
% Santosa, H., Zhai, X., Fishburn, F., & Huppert, T. (2018). The NIRS Brain AnalyzIR Toolbox. Algorithms, 11(5), 73.

% locate and add path to the nirs toolbox
nirstoolboxdir = uigetdir();
addpath(genpath(nirstoolboxdir));

% locate and add path to data analysis folder with scripts and data
analysesdir = uigetdir();
addpath(genpath(analysesdir));

%% Add path to 3D plotting package 

addpath(genpath('xxx/xxx/xxx/3D Plotting/'));

%% Load dataset 

load GroupStats_Contrasts_9Dec21

%% Load MNI coordinates for channel location (FOR ALL CHANNELS)
% Add 3D Plotting folder to direcoty if not already added

load MNIcoord_LH.txt -ascii
load MNIcoordstd_LH.txt -ascii

MNIcoord=MNIcoord_LH;
MNIcoordstd=MNIcoordstd_LH;

%% Load MNI coordinates for channels analyzed in the study
% index of channels to remove, both hemispheres, both oxy & deoxy
% see document probe_channel_match.xlsx

% Not needed when MNI coord txt is modified to only include the channels you want to plot. 

%ch_indx = [11,12,15,16,19,20,23]; % onyl LH select 8 channels over frontal
%and temporal based on preregistration

%if ~isempty(ch_indx)
%    MNIcoord(ch_indx,:)=[];
%    MNIcoordstd(ch_indx,:)=[];  
%end

% load channel and hemisphere information
maxch = 8; %max number of channels to plot
hemich = 0; %channel number at which hemisphere changes 

%% Define what condition to plot onto 3D brain

condition = older_eds_ing_hbo;

%% Set parameters for 3D image (e.g. plotting beta values)

intensity = [condition.beta(1:maxch);condition.beta(1+hemich:maxch+hemich)];

hemicoordreverse = repmat([-1.2 1 1],maxch,1);
MNIcoord = [MNIcoord(1:maxch,:); MNIcoord(1:maxch,:).*hemicoordreverse];
MNIcoordstd = [MNIcoordstd(1:maxch,:); MNIcoordstd(1:maxch,:)];

MNIcoordstd = 3*MNIcoordstd;

%% Threshold 3D brain image by statistical values (pick one OR none of the following)

% % Threshold data plotting at Q (can specifcy significan level, q < .05)
% q_ind = zeros(size(intensity,1),1);
% q_ind([condition.q(1:maxch)<.05&condition.beta(1:maxch)>=0;condition.q(1+hemich:maxch+hemich)<.05&condition.beta(1+hemich:maxch+hemich)>=0])=1;
% 
% MNIcoord(q_ind==0,:)=[];
% MNIcoordstd(q_ind==0,:)=[];
% intensity(q_ind==0)=[];

% % For plotting all q-values regardless of sign of beta value
% q_ind = zeros(size(intensity,1),1);
% q_ind([condition.q(1:maxch)<.05;condition.q(1+hemich:maxch+hemich)<.05])=1;
% MNIcoord(q_ind==0,:)=[];
% MNIcoordstd(q_ind==0,:)=[];
% intensity(q_ind==0)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %Threshold data plotting at P (can specifcy significan level, p < .05)
% p_ind = zeros(size(intensity,1),1);
% p_ind([condition.p(1:maxch)<.05&condition.beta(1:maxch)>=0;condition.p(1+hemich:maxch+hemich)<.05&condition.beta(1+hemich:maxch+hemich)>=0])=1;
% MNIcoord(p_ind==0,:)=[];
% MNIcoordstd(p_ind==0,:)=[];
% intensity(p_ind==0)=[];

% %For plotting all p-values regardless of sign of beta value
p_ind = zeros(size(intensity,1),1);
p_ind([condition.p(1:maxch)<.05;condition.p(1+hemich:maxch+hemich)<.05])=1;
MNIcoord(p_ind==0,:)=[];
MNIcoordstd(p_ind==0,:)=[];
intensity(p_ind==0)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Threshold data plotting at ALL positive beta values. Will plot only positive activations! 
% pos_beta_ind = zeros(size(intensity,1),1);
% pos_beta_ind([condition.beta(1:maxch)>=0;condition.beta(1+hemich:maxch+hemich)>=0])=1;
% MNIcoord(pos_beta_ind==0,:)=[];
% MNIcoordstd(pos_beta_ind==0,:)=[];
% intensity(pos_beta_ind==0)=[];

%% Rescale brain template to match for kid functional data 

shiftmat_child = [repmat([-6,0,0],size(MNIcoord,1),1)];% repmat([-8,0,0],6,1); repmat([-6,0,0],11,1)];

MNIcoord = MNIcoord+shiftmat_child;

%% Create 3D plot 
% IMPORTNT: Need to manually set min and max values for intensity scale
% depending on values being plotted. Will get error message if minval
% and maxval are set below actual values. Note: check across all
% conditions and set one min and max value that coveres all conditions

figure
minval = -1;
maxval = 1;

Plot3D_channel_registration_result(intensity,MNIcoord,MNIcoordstd,[],minval,maxval);

%% END