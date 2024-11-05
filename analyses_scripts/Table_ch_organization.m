function [ tablewithchannel ] = Table_ch_organization( tablewithoutchannel )
%TABLE_CH_ORGANIZATION Summary of this function goes here
%   Detailed explanation goes here

Channelinfo=cell((size(tablewithoutchannel,1)),1);
tablewithchannel=[Channelinfo tablewithoutchannel];
tablewithchannel.Properties.VariableNames{1}='Channel';
tablewithoutchannel=sortrows(tablewithoutchannel);

chcount=1;
for i=1:size(tablewithchannel,1)
    if i==1
        tablewithchannel.Channel(i)=cellstr(strcat('CH',num2str(chcount)));
    elseif tablewithchannel.source(i)==tablewithchannel.source(i-1)&&tablewithchannel.detector(i)==tablewithchannel.detector(i-1)
        tablewithchannel.Channel(i)=cellstr(strcat('CH',num2str(chcount)));
    else
        chcount=chcount+1;
        tablewithchannel.Channel(i)=cellstr(strcat('CH',num2str(chcount)));
    end
end

tablewithchannel=[tablewithchannel.Properties.VariableNames;table2cell(tablewithchannel)];
tablewithchannel=cell2table(tablewithchannel(2:end,:),'VariableNames',tablewithchannel(1,:));
% tablewithchannel=uitable('Data',tablewithchannel);
end

