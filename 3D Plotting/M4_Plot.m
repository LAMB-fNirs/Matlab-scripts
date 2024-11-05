%% fNIRS Data Analyses - Morphosyntax Grammaticality Judgement Task
% Analyses of bilingual children with potential language/reading impariments and matched controls
% 3D plots
% Modified: July 9  2019
% Data Analyses Pipile as listed below using Huppert et al NIRS Toolbox and
% inidividualized scripts created by Frank Hu.

%%%clear all; close all;
%% Add path to analyses and plot directory
%analysesdir = uigetdir();
analysesdir = 'C:\Users\vc35\Desktop\work now\RD-bilingual\syn_vs_sem';
addpath(genpath(analysesdir)); 

addpath(genpath('C:\Users\vcaruso\Box Sync\Research\language_impairment\Data\syntax\3D Plotting'));

%% Load dataset (see M3_GLM)
load('SemSyn_all_contrasts')

beta_or_tstat = 1; th_q_p_all = 3; 
%% figure 1: all_pos_beta for single tasks and groups
Imax = 7.6; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = PoorvGood_eds_S;
        Nsub = [3,4];  titletxt = 'RD: Syn vs. Rest';
    elseif icond == 1
        condition = GoodvPoor_eds_S;
        Nsub = [1,2];  titletxt = 'C: Syn vs. rest';
    elseif icond==4
        condition = PoorvGood_incon_S;
        Nsub = [7,8];  titletxt = 'RD: Sem vs. rest';
    elseif icond==3
        condition = GoodvPoor_incon_S;
        Nsub = [5,6];  titletxt = 'C: Sem vs. rest';
    end
    chF1{icond} =func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end

%% figure 2: comparison: pos beta for comparison between Syn and Sem
Imax = 15; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_RD_syxMsem;
        Nsub = [3,4];  titletxt = 'RD: Syn > Sem';
    elseif icond == 1
        condition = Hbo_C_syxMsem;
        Nsub = [1,2];  titletxt = 'C: Syn > Sem';
    elseif icond==4
        condition = Hbo_RD_semMsyx;
        Nsub = [7,8];  titletxt = 'RD: Sem > Syn';
    elseif icond==3
        condition = Hbo_C_semMsyx;
        Nsub = [5,6];  titletxt = 'C: Sem > Syn';
    end
    chF2{icond} =func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end

%% figure 3: pos beta for comparison between C and RD for each task
Imax = 16; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_Syx_RDmC;
        Nsub = [3,4];  titletxt = 'Syn: RD > C';
    elseif icond == 1
        condition = Hbo_Syx_CmRD;
        Nsub = [1,2];  titletxt = 'Syn: C > RD';
    elseif icond==4
        condition = Hbo_Sem_RDmC;
        Nsub = [7,8];  titletxt = 'Sem: RD > C';
    elseif icond==3
        condition = Hbo_Sem_CmRD;
        Nsub = [5,6];  titletxt = 'Sem: C > RD';
    end
    func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end

%% figure 4 comparing specific conditions
Imax = 16; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_Syx_RD_edsMcorrect;
        Nsub = [3,4];  titletxt = 'Syn, RD: EDS > correct';
    elseif icond == 1
        condition = Hbo_Syx_C_edsMcorrect;
        Nsub = [1,2];  titletxt = 'Syn, C: EDS > correct';
    elseif icond==4
        condition = Hbo_Sem_RD_midMcorrect;
        Nsub = [7,8];  titletxt = 'Sem, RD: mid > correct';
    elseif icond==3
        condition = Hbo_Sem_C_midMcorrect;
        Nsub = [5,6];  titletxt = 'Sem, C: mid > correct';
    end
    func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end


%% Figure 5: comparing error and correct
Imax = 16; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_Syx_RD_errorMcorrect;
        Nsub = [3,4];  titletxt = 'Syn, RD: error > correct';
    elseif icond == 1
        condition = Hbo_Syx_C_errorMcorrect;
        Nsub = [1,2];  titletxt = 'Syn, C: error > correct';
    elseif icond==4
        condition = Hbo_Sem_RD_errorMcorrect;
        Nsub = [7,8];  titletxt = 'Sem, RD: error > correct';
    elseif icond==3
        condition = Hbo_Sem_C_errorMcorrect;
        Nsub = [5,6];  titletxt = 'Sem, C: error > correct';
    end
    func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end

%%
%%
%% figure 1B: significant positive beta
beta_or_tstat = 1; th_q_p_all = 2; Imax = 7.6; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_RD_syx;
        Nsub = [3,4];  titletxt = 'RD: Syn vs. rest (p<0.05)';
    elseif icond == 1
        condition = Hbo_C_syx;
        Nsub = [1,2];  titletxt = 'C: Syn vs. rest (p<0.05)';
    elseif icond==4
        condition = Hbo_RD_sem;
        Nsub = [7,8];  titletxt = 'RD: Sem vs. rest (p<0.05)';
    elseif icond==3
        condition = Hbo_C_sem;
        Nsub = [5,6];  titletxt = 'C: Sem vs. rest (p<0.05)';
    end
    chF1B{icond} =func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end


%% figure 2B: comparison: tstat for comparison between Syn and Sem
beta_or_tstat = 1; th_q_p_all = 2; Imax = 15; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_RD_syxMsem;
        Nsub = [3,4];  titletxt = 'RD: Syn > Sem (p<0.05)';
    elseif icond == 1
        condition = Hbo_C_syxMsem;
        Nsub = [1,2];  titletxt = 'C: Syn > Sem (p<0.05)';
    elseif icond==4
        condition = Hbo_RD_semMsyx;
        Nsub = [7,8];  titletxt = 'RD: Sem > Syn (p<0.05)';
    elseif icond==3
        condition = Hbo_C_semMsyx;
        Nsub = [5,6];  titletxt = 'C: Sem > Syn (p<0.05)';
    end
    chF2B{icond} =func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end
%% figure 3B comparison between C and RD for each task
beta_or_tstat = 1; th_q_p_all = 2; Imax = 16; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_Syx_RDmC;
        Nsub = [3,4];  titletxt = 'Syn: RD > C (p<0.05)';
    elseif icond == 1
        condition = Hbo_Syx_CmRD;
        Nsub = [1,2];  titletxt = 'Syn: C > RD (p<0.05)';
    elseif icond==4
        condition = Hbo_Sem_RDmC;
        Nsub = [7,8];  titletxt = 'Sem: RD > C (p<0.05)';
    elseif icond==3
        condition = Hbo_Sem_CmRD;
        Nsub = [5,6];  titletxt = 'Sem: C > RD (p<0.05)';
    end
   chF3B{icond} = func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end
%% figure 4B comparing specific conditions
beta_or_tstat = 1; th_q_p_all = 2; Imax = 16; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_Syx_RD_edsMcorrect;
        Nsub = [3,4];  titletxt = 'Syn, RD: EDS > correct (p<0.05)';
    elseif icond == 1
        condition = Hbo_Syx_C_edsMcorrect;
        Nsub = [1,2];  titletxt = 'Syn, C: EDS > correct (p<0.05)';
    elseif icond==4
        condition = Hbo_Sem_RD_midMcorrect;
        Nsub = [7,8];  titletxt = 'Sem, RD: mid > correct (p<0.05)';
    elseif icond==3
        condition = Hbo_Sem_C_midMcorrect;
        Nsub = [5,6];  titletxt = 'Sem, C: mid > correct (p<0.05)';
    end
    chF4B{icond} =func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end

%% Figure 5B: comparing error and correct
beta_or_tstat = 1; th_q_p_all = 2; Imax = 16; Imin=-Imax; R=2;C=4;
figure
for icond=1:4
    if icond == 2
        condition = Hbo_Syx_RD_errorMcorrect;
        Nsub = [3,4];  titletxt = 'Syn, RD: error > correct (p<0.05)';
    elseif icond ==1
        condition = Hbo_Syx_C_errorMcorrect;
        Nsub = [1,2];  titletxt = 'Syn, C: error > correct (p<0.05)';
    elseif icond==4
        condition = Hbo_Sem_RD_errorMcorrect;
        Nsub = [7,8];  titletxt = 'Sem, RD: error > correct (p<0.05)';
    elseif icond==3
        condition = Hbo_Sem_C_errorMcorrect;
        Nsub = [5,6];  titletxt = 'Sem, C: error > correct (p<0.05)';
    end
   chF5B{icond} = func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin,R,C,Nsub,titletxt);
end
