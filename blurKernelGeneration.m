% Define the subdirectory name
subdir_name = 'blur_kernels';

% Check if the subdirectory exists, if not, create it
if ~exist(subdir_name, 'dir')
    mkdir(subdir_name);
end

% Define the anxiety (A) and exposure (E) levels
A_levels = [0.005, 0.001, 0.00005];
E_levels = [1/25, 1/10, 1/5];

% Define output kernel size
kernel_size = [32, 32];

% Trajectory curve parameters
PSFsize = 32;
numT = 2000;
MaxTotalLength = 64;
do_show = 0;
do_center = 1;


% Iterate over each combination of A and E levels
for i = 1:length(A_levels)
    for j = 1:length(E_levels)
        % Generate the trajectory using the createTrajectory function
        Trajectory = createTrajectory(PSFsize, A_levels(i), numT, MaxTotalLength, do_show); % Include other necessary parameters

        % Generate the PSF using the createPSFs function
        PSF = createPSFs(Trajectory, PSFsize, E_levels(j), do_show, do_center); % Include other necessary parameters
        PSF_matrix = PSF{1}; % Access the first element since there is only 1 PSF per cell
        
        % Normalize the PSF to the range [0, 1]
        PSF_normalized = mat2gray(PSF_matrix);
        
        % Replicate the grayscale PSF across three channels to create an RGB image
        PSF_rgb = repmat(PSF_normalized, [1 1 3]);

        % Convert to uint8
        PSF_uint8 = im2uint8(PSF_rgb);

        % Construct the filename with the subdirectory
        filename = fullfile(subdir_name, sprintf('kernel_A%d_E%d.jpg', i, j));

        % Write the file to the subdirectory
        imwrite(PSF_uint8, filename);
      
    end
end
