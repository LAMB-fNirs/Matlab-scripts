function BAfinding(radius)
%% Created by Xiaosu Hu 
load digpts_MNI.txt -ascii;
load TDdatabase.mat;

digpts_mni=digpts_MNI;
ch=size(digpts_mni,1);

for i=1:ch

xlist = []; % ???????
ylist = [];
zlist = [];
cnt = 0;
while cnt < 10000 %# of dots
    x = (rand()-.5)*2*sqrt(radius)+digpts_mni(i,1);%
    y = (rand()-.5)*2*sqrt(radius)+digpts_mni(i,2);
    z = (rand()-.5)*2*sqrt(radius)+digpts_mni(i,3);
    if (x-digpts_mni(i,1))^2 + (y-digpts_mni(i,2))^2 + (z-digpts_mni(i,3))^2 <= radius % Radius
        cnt = cnt + 1;
        xlist(cnt) = x;
        ylist(cnt) = y;
        zlist(cnt) = z;
    end
end

% plot3(xlist, ylist, zlist, 'or'); % ??????????


mni_xyz=[xlist' ylist' zlist'];

[a,BA{i}]=StructureFinding(mni_xyz, DB);

end



% dot count

for i=1:ch
    
    for j=1:length(BA{i})
        try
           BA_update(j,i)=str2num(BA{i}{j,5}(15:end));
           
        catch
           BA_update(j,i)=0; 
        end
    end
    
end

for i=1:ch
    tmp=BA_update(:,i);
    tmp(tmp==0)=[];
    BA_results{i}=tabulate(tmp(:,1));
    try
        BA_results{i}((BA_results{i}(:,2))==0,:)=[];
    catch
        BA_results{i}=[0,10000,100];
    end
end

%% A result sort process
for i=1:ch
    [BA_result_sort{i}(:,3),I]=sort(BA_results{i}(:,3),'descend');
     BA_result_sort{i}(:,2)=BA_results{i}(I,2);
     BA_result_sort{i}(:,1)=BA_results{i}(I,1);
end

BA_results=BA_result_sort;
%% Ploting process
figure



for i=1:ch
    subplot(3,ceil(ch/3),i)
     
    switch size(BA_results{i},1)
        
        case 1
            p=pie(BA_results{i}(:,3)/100,{num2str(BA_results{i}(1,1))});
            title(strcat('CH',num2str(i)),'FontSize',18);
            set(p(1),'FaceColor','green')
            set(p(2),'FontSize',18)
            
        case 2
            p=pie(BA_results{i}(:,3)'/100,{num2str(BA_results{i}(1,1)),num2str(BA_results{i}(2,1))});
            title(strcat('CH',num2str(i)),'FontSize',18);
            set(p(1),'FaceColor','green')
            set(p(2),'FontSize',18)
            set(p(3),'FaceColor','red')
            set(p(4),'FontSize',18)
        case 3
            p=pie(BA_results{i}(:,3)'/100,{ num2str(BA_results{i}(1,1)),num2str(BA_results{i}(2,1)),num2str(BA_results{i}(3,1))});
            title(strcat('CH',num2str(i)),'FontSize',18);
            set(p(1),'FaceColor','green')
            set(p(2),'FontSize',18)
            set(p(3),'FaceColor','red')
            set(p(4),'FontSize',18)
            set(p(5),'FaceColor','blue')
            set(p(6),'FontSize',18)
            
        case 4
            p=pie(BA_results{i}(:,3)'/100,{num2str(BA_results{i}(1,1)),num2str(BA_results{i}(2,1)),num2str(BA_results{i}(3,1)),num2str(BA_results{i}(4,1))});
            title(strcat('CH',num2str(i)),'FontSize',18);
             set(p(1),'FaceColor','green')
            set(p(2),'FontSize',18)
            set(p(3),'FaceColor','red')
            set(p(4),'FontSize',18)
            set(p(5),'FaceColor','blue')
            set(p(6),'FontSize',18)
            set(p(7),'FaceColor','yellow')
            set(p(8),'FontSize',18)
        case 5
            p=pie(BA_results{i}(:,3)'/100,{num2str(BA_results{i}(1,1)),num2str(BA_results{i}(2,1)),num2str(BA_results{i}(3,1)),num2str(BA_results{i}(4,1)),num2str(BA_results{i}(5,1))});
            title(strcat('CH',num2str(i)),'FontSize',18);
             set(p(1),'FaceColor','green')
            set(p(2),'FontSize',18)
            set(p(3),'FaceColor','red')
            set(p(4),'FontSize',18)
            set(p(5),'FaceColor','blue')
            set(p(6),'FontSize',18)
            set(p(7),'FaceColor','yellow')
            set(p(8),'FontSize',18)
             set(p(9),'FaceColor','cyan')
            set(p(10),'FontSize',18)
        case 6
            p=pie(BA_results{i}(:,3)'/100,{num2str(BA_results{i}(1,1)),num2str(BA_results{i}(2,1)),num2str(BA_results{i}(3,1)),num2str(BA_results{i}(4,1)),num2str(BA_results{i}(5,1)),num2str(BA_results{i}(6,1))});
            title(strcat('CH',num2str(i)),'FontSize',18);
            set(p(1),'FaceColor','green')
            set(p(2),'FontSize',18)
            set(p(3),'FaceColor','red')
            set(p(4),'FontSize',18)
            set(p(5),'FaceColor','blue')
            set(p(6),'FontSize',18)
            set(p(7),'FaceColor','yellow')
            set(p(8),'FontSize',18)
             set(p(9),'FaceColor','cyan')
            set(p(10),'FontSize',18)
            set(p(11),'FaceColor','magenta')
            set(p(12),'FontSize',18)
            
    end
end

