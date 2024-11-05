function fs2viewer = initFs2Viewer(handles,dirname)

fs2viewer = struct(...
                   'handles', struct('menuItemFs2Viewer',handles.menuItemFs2Viewer), ...
                   'pialsurf_l_fn','surf/lh.pial',...
                   'pialsurf_r_fn','surf/rh.pial',...
                   'hsegvol_fn','mri/hseg.nii',...
                   'headvol_fn','mri/T1.nii',...
                   'brainvol_fn','mri/aseg.nii',...
                   'wmvol_fn','mri/wm.nii', ...
                   'threshold', 30, ... 
                   'checkCompatability',[], ...
                   'prepObjForSave',[] ...
                  );

if (~exist([dirname 'anatomical/headsurf.mesh'],'file') && ...
    ~exist([dirname 'anatomical/headvol.vox'],'file')) || ...
    ~exist([dirname 'anatomical/pialsurf.mesh'],'file')

    if exist([dirname, fs2viewer.hsegvol_fn],'file')
        set(fs2viewer.handles.menuItemFs2Viewer,'enable','on');
    elseif exist([dirname, fs2viewer.headvol_fn],'file')
        set(fs2viewer.handles.menuItemFs2Viewer,'enable','on');
    else
        % set(fs2viewer.handles.menuItemFs2Viewer,'enable','off');
    end

else

    %set(fs2viewer.handles.menuItemFs2Viewer,'enable','off');

end
