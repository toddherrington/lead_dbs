function    ea_checkfiles(options)
% load files
if strcmp(options.prefs.patientdir,'Choose Patient Directory')
    ea_error('Please choose patient directory first');
end


vfi={'tra','cor','sag'};
bb=spm_vol([options.earoot,'templates',filesep,'bb.nii']);
for tracor=1:length(vfi)
    cf=[options.root,options.prefs.patientdir,filesep,options.prefs.([vfi{tracor},'nii'])];
    [pth,fn,ext]=fileparts(cf);
    try
        nii=spm_vol(cf);
        if ~isequal(bb.mat,nii.mat)
            % export images that have wrong dimension with correct bounding box
            
            matlabbatch{1}.spm.util.imcalc.input = {[options.earoot,'templates',filesep,'bb.nii,1'];
                cf};
            matlabbatch{1}.spm.util.imcalc.output = [fn,ext];
            matlabbatch{1}.spm.util.imcalc.outdir = {pth};
            matlabbatch{1}.spm.util.imcalc.expression = ['i2'];
            matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
            matlabbatch{1}.spm.util.imcalc.options.mask = 0;
            matlabbatch{1}.spm.util.imcalc.options.interp = 1;
            matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
            jobs{1}=matlabbatch;
            cfg_util('run',jobs);
            clear matlabbatch jobs;
            
        end
    catch
        if tracor==1
            ea_error('Please put a suitable anatomy file inside patient folder');
        end
        warning([fn,' not present']);
    end
    
end




