# EmoRecTFR

## Data Processing

The Data that I used was already grouped according to Emotions.

1. Load Data into MATLAB and run splitting_mat_files_into_6_components.m
2. Run separating_data_into_fields.m
3. Run getting_processed_imgs.m

After running these 3 files, the directory of each emotion should be similar to the following:  

 <img width="222" alt="Screenshot 2022-07-12 at 11 24 01 AM" src="https://user-images.githubusercontent.com/65991949/178401995-cfc18460-2c92-4a25-a4a9-bfd82ec9fb36.png">

The images obtained from the getting_processed_imgs.m have a title and legend in them. This might affect the learning process of the ResNet50, as a result of which the images need to be cropped. 

4. Run crop_imgs.py --> uses moving_cropped_imgs.py and helper_functions.py
