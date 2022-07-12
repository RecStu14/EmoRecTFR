%LOADING DATA INTO MATLAB

%This code is the first code to be run, it includes extracting the 6 trials
%from each of the participant's data. Foe example. s1.mat will contain 6
%trial data. This code extracts the 6 trials out and stores them as
%separate matfiles.

%Clearing the Command Window
clc;

%Ensuring the workspace can be seen
workspace;

%Formatting the display of the output with compact spacing
format longg
format compact

%Seeing the current Working directory
current_folder = pwd;

%Initialising a few directories
%strcat() is used to concatenate strings
parent_dir = strcat(current_folder(1:51),'Datasets/');
matlab_data_dir = strcat(parent_dir, 'matlab_data/');

%Navigate to the matlab_data_dir
cd(matlab_data_dir);
emotion_dir = dir; %where emotion_dir is a struct_arr

%Getting the names of the folders
%the names of the folders are read as a struct arr with their sizes, name
%and paths also written. Hence, to be able to read only their names we
%extract a part of the struct arr using extractfield()
emotion_names = extractfield(emotion_dir,'name');

%Deleting the unnecessary elements from the cell array
emotion_names(1:3) = [];
emotion_names{8} = [];

%Iterating over the number of emotions
for i=1:length(emotion_names)-4
    %defining the path
    path = strcat(matlab_data_dir,string(emotion_names{i}));

    %navigating into the emotion_directory
    cd(path)

    %dir reads the folders and the files in that directory
    session_dir = dir; %session_dir is a struct array

    %getting the names
    session_names = extractfield(session_dir, 'name');

    %Deleting the unnecessary elements from the cell array
    session_names(1:4) = [];
    
    %iterating over the number of sessions
    for j=1:length(session_names)
        %redefining the path
        path = strcat(matlab_data_dir,string(emotion_names{i}), '/', string(session_names{j}));
        
        %navigating into the session directory and reading it contents
        cd(path)
        folder_dir = dir;

        %extracting the names of the folders
        folder_names = extractfield(folder_dir, 'name');
        
        %to make the folder names contain only the folder names eg s1 etc,
        %instead of . and .. etc. ie: removing the unnecessary elements
        %strcmp() is used to compare 2 strings
        if strcmp(emotion_names{i},'0_neutral')
            if strcmp(session_names{j},'Session_1')
                folder_names(1:4) = [];
            end
            if strcmp(session_names{j},'Session_2')
                folder_names(1:3) = [];
            end
            if strcmp(session_names{j},'Session_3')
                folder_names(1:3) = [];
            end

        else
            folder_names(1:2) = [];
        end

        %The sizes and th elements of 0_neutral are slightly different as
        %they contain extra elements like 'DS_Store' and
        %'.ipynb_checkpoints', for which I have no idea as to why, but
        %anyway, we need to write a special if-else block to remve the
        %extra unnecessary elements in the array. For teh other emotions
        %arrays, they just have a . and a .. extra in their array, hence we
        %just need to remove the 1st 2 elements
 
        
        %iterating over the number of folder names in each session
        %directory
        for k=1:length(folder_names)
            %redefining the path
            path = strcat(matlab_data_dir,string(emotion_names{i}), '/', string(session_names{j}), '/', string(folder_names{k}));
            
            %entering the s1 folders etc to read the s1.mat file etc, and
            %extracting out the names of the files in the folders
            cd(path)
            mat_dir = dir;
            mat_files = extractfield(mat_dir, 'name');
            
            %an if-else loop to remove the unnecessary elements in the
            %array
            if (length(mat_files) == 4)
                mat_files(1:3) = [];
            elseif (length(mat_files) == 3)
                mat_files(1:2) = [];
            end
            
            %redefining the path to be the full path of the .mat file
            path = strcat(matlab_data_dir,string(emotion_names{i}), '/', string(session_names{j}), '/', string(folder_names{k}), '/', string(mat_files));
            
            %loading the corresponding .mat file into the variable
            %mat_ext_file
            mat_ext_file = load(path);

            %getting the fieldnames of the struct arr
            field_names = fieldnames(mat_ext_file);
            
            %Converting the struct arr into a cell arr and storing it in
            %the variable values. Therefore, values beocmes a 6x1 cell.
            %Where each row refers to the double type variable of each
            %trial.
            values = struct2cell(mat_ext_file);

            %Storing each of these double type variables into separate
            %variables by accessing the values variable.
            trial_1 = values{1,1};
            trial_2 = values{2,1};
            trial_3 = values{3,1};
            trial_4 = values{4,1};
            trial_5 = values{5,1};
            trial_6 = values{6,1};

            %saving these variables into .mat extension in their respective
            %folders. This gets stored as a 1x1 struct arr that contains
            %the corresponding trial data. Despite being a struct arr, it
            %is still loadable into EEGLAB.
            save('trial1.mat','trial_1');
            save('trial2.mat','trial_2');
            save('trial3.mat','trial_3');
            save('trial4.mat','trial_4');
            save('trial5.mat','trial_5');
            save('trial6.mat','trial_6');
           
        end
    end
end





