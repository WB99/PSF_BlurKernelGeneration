% Check if the subdirectory exists, if not, create it
blurLevels = {'l_1', 'l_2', 'l_3'};
baseDir = 'blur_kernels_levelwise';

if ~exist(baseDir, 'dir')
    mkdir(baseDir);
end

for b = 1:length(blurLevels)
    levelDir = fullfile(baseDir, blurLevels{b});
    if ~exist(levelDir, 'dir')
        mkdir(levelDir);
    end
end

% Define the anxiety (A) and exposure (E) levels
A_levels = [0.005, 0.001, 0.00005];
E_levels = [1/25, 1/10, 1/5];

% Trajectory curve parameters
PSFsize = 32;
numT = 2000;
MaxTotalLength = 64;
do_show = 0;
do_center = 1;
numKernelsPerLevel = 100; % Number of kernels to generate per A&E combination

% Generate and save the kernels
for a = 1:length(A_levels)
    for e = 1:length(E_levels)
        for k = 1:numKernelsPerLevel
            % Generate the trajectory
            Trajectory = createTrajectory(PSFsize, A_levels(a), numT, MaxTotalLength, do_show);

            % Generate the PSF
            PSF = createPSFs(Trajectory, PSFsize, E_levels(e), do_show, do_center);
            PSF_matrix = PSF{1}; % Assuming PSF is a cell array

            % Convert PSF to RGB
            PSF_normalized = mat2gray(PSF_matrix);
            PSF_rgb = repmat(PSF_normalized, [1 1 3]);
            PSF_uint8_rgb = im2uint8(PSF_rgb);

            % Construct the directory and filename
            subdir = fullfile(baseDir, ['l_', num2str(e)]);
            filename = fullfile(subdir, sprintf('kernel_A%d_E%d_%d.jpg', a, e, k));

            % Write the kernel image to the file
            imwrite(PSF_uint8_rgb, filename);
        end
    end
end
