function [Hbo_contrast,T_contrast_test] = fund_get_contrast_to_plot(GroupStats, c)


%c = [1 0 0 0];

contrast_test    = GroupStats.ttest(c); 
T_contrast_test  = contrast_test.table;
Hbo_contrast     = T_contrast_test(strcmp(T_contrast_test.type,'hbo'),:);



% % %% ROI
% % ct=Tcd2;
% % Region = table([1],[3],'VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch3'}))
% % Region = table([1],[4],'VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch4'}))
% % Region = table([2],[3],'VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch5'}))
% % Region = table([1,1,2]',[3,4,3]','VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch3-4-5'}))
% % 
% % Region = table([9],[19],'VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch26'}))
% % Region = table([9],[20],'VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch27'}))
% % Region = table([10],[19],'VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch28'}))
% % Region = table([9,9,10]',[19,20,19]','VariableNames',{'source','detector'}); disp(nirs.util.roiAverage(ct,Region,{'Ch26-27-28'}))

end

