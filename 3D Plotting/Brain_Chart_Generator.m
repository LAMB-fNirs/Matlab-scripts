
load('MNI152_downsampled.mat');
figure
patch('faces',faces,'vertices',vertices,'facecolor',[.8 .8 .8],'edgecolor', 'none')

view([90 90]);
camlight('headlight','infinite');
lighting gouraud
material dull;

view([-90 0]);
camlight('headlight','infinite');
lighting gouraud
material dull;