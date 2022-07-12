%SEPARATING THE .MAT FILES INTO 6 COMPONENTS

PARENT_DIR = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/github_try";

NEUTRAL_DIR = strcat(PARENT_DIR,"/0_neutral");
SAD_DIR = strcat(PARENT_DIR,"/1_sad");
FEAR_DIR = strcat(PARENT_DIR,"/2_fear");
HAPPY_DIR = strcat(PARENT_DIR,"/3_happy");

SESSION_1 = strcat(HAPPY_DIR,"/Session_1/");
SESSION_2 = strcat(HAPPY_DIR,"/Session_2/");
SESSION_3 = strcat(HAPPY_DIR,"/Session_3/");

%change sesion value here
%----------------------- MAKE A SELECTION ---------------------------------
session_contents = dir(SESSION_3);
%--------------------------------------------------------------------------

%Extracting out only the s1-s15, removing unecessary names
if length(session_contents) == 19
    session_contents = session_contents(5:end);
    folder_list = extractfield(session_contents,'name');
elseif length(session_contents) == 18
    session_contents = session_contents(4:end);
    folder_list = extractfield(session_contents,'name');
elseif length(session_contents) == 17
    session_contents = session_contents(3:end);
    folder_list = extractfield(session_contents,'name');
elseif length(session_contents) == 16
    session_contents = session_contents(2:end);
    folder_list = extractfield(session_contents,'name');
end

for i=1:length(folder_list)
    %change session value here
    %---------------CHANGE SESSION VALUE ACCORDINGLY-----------------------
    chosen_path = strcat(SESSION_3,folder_list(i));
    %----------------------------------------------------------------------
    mat_file_list = dir(chosen_path);
    mat_file_struct = mat_file_list(end);
    mat_file_path = string(extractfield(mat_file_struct,'folder'));
   
    cd(mat_file_path);
    mat_file = load(string(extractfield(mat_file_struct,'name')));

    field_names = fieldnames(mat_file);

    for j=1:length(field_names)
        component = extractfield(mat_file,string(field_names(j)));
        current_field = string(field_names(j));
        save(strcat(current_field,'.mat'),"component");
    end

    disp(strcat("Successfully splitted ", folder_list(i)));
end


