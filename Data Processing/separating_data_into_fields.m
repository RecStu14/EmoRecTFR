%PROCESSING DATA

%Since the datasets (0_neutral, 1_sad etc.) are read as struct arrays in
%MATLAB which contain the data of different trials in fields. We would need
%to extract the fields out and store them as separate matfiles.

%Parent Directory
PARENT_DIR = '/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/github_try/';

%Emotion Directory
NEUTRAL_DIR = strcat(PARENT_DIR,'0_neutral/');
SAD_DIR = strcat(PARENT_DIR,'1_sad/');
FEAR_DIR = strcat(PARENT_DIR,'2_fear/');
HAPPY_DIR = strcat(PARENT_DIR,'3_happy/');

%To allow the path to be flexible for any emotions - the variables that
%are enclosed within dashed lines have to be changed in each run. This
%could be automated by adding a for loop however doing so sinificantly
%slows down the process.

% -------------------------- MAKE A SELECTION ----------------------------
chosen_emotion = NEUTRAL_DIR;
% ------------------------------------------------------------------------

%Initialising the Session specific paths
session1_path = strcat(chosen_emotion,'Session_1/');
session2_path = strcat(chosen_emotion,'Session_2/');
session3_path = strcat(chosen_emotion,'Session_3/');


% -------------------------- MAKE A SELECTION ----------------------------
chosen_path = session1_path;
% ------------------------------------------------------------------------


%Returns a struct array that contains the names of the folder s1 etc and
%slicing this to contain only the wanted 15 folder names and details
folder_list = dir(chosen_path);

if length(folder_list) == 19
    folder_list = folder_list(5:end);
elseif length(folder_list) == 18
    folder_list = folder_list(4:end);
elseif length(folder_list) == 17
    folder_list = folder_list(3:end);
end

%Extracting only the names out
folder_names = extractfield(folder_list,'name');

disp(folder_names)

for i=1:length(folder_names)
    path = strcat(chosen_path,string(folder_names(i)),'/');
    cd(path)
    
    mat_file = load(strcat(path,string(folder_names(i)),'.mat'));

    %Getting the fieldnames and storing it in a cell array
    field_names = fieldnames(mat_file);

    for j=1:length(field_names)
        current_field = string(field_names(j));
        current_portion = extractfield(mat_file,current_field);
        save(strcat(current_field,'.mat'),"current_portion")
    end
end

%mat_file = load(path);
%field_names = fieldnames(mat_file);

%disp(field_names)
