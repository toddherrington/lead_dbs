function ea_coregmr_ants(options)
% uses ANTs instead of SPM to coregister MRIs.

disp('Interpolating preoperative anatomical image');
ea_normalize_reslicepretra(options);
disp('Done.');
disp('Coregistering postop MR tra to preop MRI...');

ea_ants([options.root,options.patientname,filesep,options.prefs.prenii_unnormalized],...
          [options.root,options.patientname,filesep,options.prefs.tranii_unnormalized],...
          [options.root,options.patientname,filesep,options.prefs.tranii_unnormalized],0)
disp('Coregistration done.');

if exist([options.root,options.patientname,filesep,options.prefs.cornii_unnormalized],'file');
    disp('Coregistering postop MR tra to preop MRI...');
    ea_ants([options.root,options.patientname,filesep,options.prefs.prenii_unnormalized],...
        [options.root,options.patientname,filesep,options.prefs.cornii_unnormalized],...
        [options.root,options.patientname,filesep,options.prefs.cornii_unnormalized],0)
    disp('Coregistration done.');
end

if exist([options.root,options.patientname,filesep,options.prefs.sagnii_unnormalized],'file');
    disp('Coregistering postop MR tra to preop MRI...');

    ea_ants([options.root,options.patientname,filesep,options.prefs.prenii_unnormalized],...
        [options.root,options.patientname,filesep,options.prefs.sagnii_unnormalized],...
        [options.root,options.patientname,filesep,options.prefs.sagnii_unnormalized],0)
    disp('Coregistration done.');
end