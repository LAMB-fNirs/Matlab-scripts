function [channels] = func_make_plot(condition,th_q_p_all,beta_or_tstat,Imax,Imin, R,C,Nsubplot,titletxt)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %% 3D Visualization & Brain Plots
    % Load MNI coordinates for channel location
    load MNIcoordB.txt -ascii % this one considers 19 ch (excludes the back ch 20-21-22-23). If one wants all 23 channels: use MNIcoord
    load MNIcoordstdB.txt -ascii %same as above
    
    % Load channel and hemisphere information
    maxch = 16; %max number of channels to plot (23 if all ch considered)
    hemich = 16; %channel number at which hemisphere changes (23 always if the cap has 23 ch per side)
    
    % Set parameters for image (e.g. plotting beta values)
    if beta_or_tstat==1 %beta
        intensity = [condition.beta]; %can change beta to tstat or p, or q, any of the columns in the conditiobn variable
    else %tstat
        intensity = [condition.tstat]; %can change beta to tstat or p, or q, any of the columns in the conditiobn variable
    end
    
    hemicoordreverse = repmat([-1.2 1 1],maxch,1);
    MNIcoord = [MNIcoordB(1:maxch,:); MNIcoordB(1:maxch,:).*hemicoordreverse];
    MNIcoordstd = [MNIcoordstdB(1:maxch,:); MNIcoordstdB(1:maxch,:)];
    MNIcoordstd = 3*MNIcoordstd;
    
    %% ROI: chose the channels to plot
    chosen_ch = zeros(32,1);
    chosen_ch_id = [1:24,26:31];
    chosen_ch(chosen_ch_id)=1;
    all_ch_id=1:32;
    
    %% Threshold 3D brain image by p or q values (pick one OR none of the following)
    channels = all_ch_id; 
    if th_q_p_all ==1 %q
        % Threshold data plotting at Q (can specifcy significan level, q < .05)
        q_ind = zeros(size(intensity,1),1);
        q_ind([condition.q<.05 & condition.beta>=0 & chosen_ch==1])=1;
        MNIcoord(q_ind==0,:)=[];
        MNIcoordstd(q_ind==0,:)=[];
        intensity(q_ind==0)=[];
        channels(q_ind==0)=[];% return the channels that are plot 
    elseif th_q_p_all ==2 %p
        % Threshold data plotting at P (can specifcy significan level, p < .05)
        p_ind = zeros(size(intensity,1),1);
        p_ind([condition.p<.05 & condition.beta>=0 & chosen_ch==1])=1;
        MNIcoord(p_ind==0,:)=[];
        MNIcoordstd(p_ind==0,:)=[];
        intensity(p_ind==0)=[];
        channels(p_ind==0)=[];% return the channels that are plot 
    elseif th_q_p_all ==3
        %Threshold data plotting at ALL positive beta values. Will plot only positive activations!
        pos_beta_ind = zeros(size(intensity,1),1);
        pos_beta_ind([condition.beta>=0 & chosen_ch==1])=1;
        MNIcoord(pos_beta_ind==0,:)=[];
        MNIcoordstd(pos_beta_ind==0,:)=[];
        intensity(pos_beta_ind==0)=[];
        channels(pos_beta_ind==0)=[];% return the channels that are plot 
    end
    
    % Rescale brain template to match for kid functional data
    shiftmat_child = [repmat([-6,0,0],size(MNIcoord,1),1)];% repmat([-8,0,0],6,1); repmat([-6,0,0],11,1)];
    MNIcoord = MNIcoord+shiftmat_child;
   
    
    %% Create 3D Plot
    % IMPORTNT: Need to manually set min and max values for intensity scale depending on beta values being plotted (variable intensity)
    % Will get error message if minval and maxval are set below actucal values.
    % Note: check across all conditions and set one min and max value that coveres all conditions
    if ~isempty(intensity)
        minval = Imin;
        maxval = Imax;
        subplot(R,C,Nsubplot(1))
        Plot3D_channel_registration_result(intensity,MNIcoord,MNIcoordstd,[],minval,maxval);
        title(titletxt)
        subplot(R,C,Nsubplot(2))
        Plot3D_channel_registration_result(intensity,MNIcoord,MNIcoordstd,[],minval,maxval);
        view([90,0]);
    end

end

