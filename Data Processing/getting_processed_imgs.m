%GETTING THE IMAGES - FSST/STFT

%This code is to obtain the STFT or FSST applied time frequency
%representations in the form of Spectrogram Images.
%Number of Variables to change = 3

PARENT_DIR = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test";


NEUTRAL_DIR = strcat(PARENT_DIR,"/0_neutral");
SAD_DIR = strcat(PARENT_DIR,"/1_sad");
FEAR_DIR = strcat(PARENT_DIR,"/2_fear");
HAPPY_DIR = strcat(PARENT_DIR,"/3_happy");

%change emotion here
SESSION_1 = strcat(HAPPY_DIR,"/Session_1/");
SESSION_2 = strcat(HAPPY_DIR,"/Session_2/");
SESSION_3 = strcat(HAPPY_DIR,"/Session_3/");

%change sesion value here
%------------------------- MAKE A SELECTION -------------------------------
session_contents = dir(SESSION_2);
%--------------------------------------------------------------------------

%Extracting out only the s1-s15, removing unecessary names
%if length(session_contents) == 19
%    session_contents = session_contents(5:end);
%    folder_list = extractfield(session_contents,'name');
%elseif length(session_contents) == 18
%    session_contents = session_contents(4:end);
%    folder_list = extractfield(session_contents,'name');
%elseif length(session_contents) == 17
%    session_contents = session_contents(3:end);
%    folder_list = extractfield(session_contents,'name');
%elseif length(session_contents) == 16
%    session_contents = session_contents(2:end);
%    folder_list = extractfield(session_contents,'name');
%end

folder_list = {"s1","s2","s3","s4","s5","s6","s7","s8","s9","s10","s11","s12","s13","s14","s15"};
%folder_list = {"s3","s4","s5","s6","s7","s8","s9","s10","s11","s12","s13","s14","s15"};
%folder_list = {"s2"};

for i=1:length(folder_list)
    %change session number here too
    %-------------- CHANGE SESSION NUMBER ACCORDINGLY----------------------
    chosen_path = strcat(SESSION_2,string(folder_list(i)));
    %----------------------------------------------------------------------

    folder_contents = dir(chosen_path);
    disp(folder_contents);
    
    %Getting a list of all the .mat files in the folder and extracting the name
    %field from the struct array
    names = extractfield(folder_contents,'name');
   
    
    %Creating an array with placeholder values to hold the actual section names
    %eg cz_eeg4_1.mat
    filtered_mat_names = {1,2,3,4,5,6};
    
    %To assign the actual section names to the filtered_mat_names 
    index = 1;
    
    %For loop to extract the section names out
    for j=1:length(names)
        %Converting each element of mat_file_names into a String to do string
        %comparison
        element = string(names(j));
        
        %if loop to extract the section names out
        if contains(element,'eeg')
            filtered_mat_names{index} = element;
            index = index + 1;
        end
    end

    %iterating through the filtered_mat_names which contains the names for
    %each of the 6 components and loading them in
    for k=1:length(filtered_mat_names)
        path = strcat(chosen_path,'/',string(filtered_mat_names(k)));
        mat_file = load(path);
        
        section = mat_file.component;
        
        %to reshape it into num_channels x length_signal
        section = reshape(section,62,[]);


        %defining the start and the end position of each snippet
        start_position = 1;
        end_position = 200;
        
        %Max possible index is num_rows * num_cols
        max_possible_idx = (length(section)*62);
        
        %create a ts duration array
        ts = seconds(0.9);
        counter = 1;

        tries = round(length(section) / 200);

        for p=1:tries

            %finding the min value between the calculated end_position and the max
            %possible index, this ensures that the end position is always within
            %the max possible length and all the handful few values that are
            %leftover will be counted3
            end_position = min(end_position,length(section));
                  
            %Extracting - section(num_rows_needed, num_cols_needed)
            %right now just taking the first 200 values regardless of the
            %channels when i call out x , otherwise earlier i was doing it
            %using portion_vector w more than 200 values
            portion = section(1:end,start_position:end_position);
            
            if start_position == end_position
                portion = section(1:end,end);
                x = section(1:end,end);
            end

            %portion is 62x200
            portion_vector = reshape(portion,[],1);
            x = section(start_position:end_position);

            
            %navigating to the sX folder
            cd(chosen_path)
           
            component_name_list = strsplit(string(filtered_mat_names(k)),".");
            
            mkdir stft_images;
            cd('stft_images')

            cla reset;
            %disp(start_position);
            %disp(end_position);
            if isequal(length(x),1)
                continue
            else
                %----------------- CHOOSE BETWEEN SST OR FSST--------------
                %fsst(x,ts,'yaxis');
                stft(x,ts);
                %----------------------------------------------------------
                f = gcf;
                img_name = strcat(component_name_list(1),"_img_",string(counter),".jpg");
                    
                %exportgraphics(gcf,sprintf('image%d.jpg',counter));
                saveas(f,img_name)
                clf;
                start_position = start_position + 200;
                end_position = end_position + 200;
                counter = counter + 1;
            end
        end  
    end
    disp("Successfully finished 1 component!")
end


