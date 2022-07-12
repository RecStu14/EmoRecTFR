# EmoRecTFR

## Data Processing 
The Data that I used was already grouped according to Emotions.

1. Load Data into MATLAB and run splitting_mat_files_into_6_components.m
2. Run separating_data_into_fields.m
3. Run getting_processed_imgs.m

After running these 3 files, the directory of each emotion should be similar to the following:
0_neutral
  ├── Session_1
  │   ├── s1
  │   │   ├── cz_eeg21_1.mat
  │   │   ├── cz_eeg23_1.mat
  │   │   ├── cz_eeg4_1.mat
  │   │   ├── cz_eeg6_1.mat
  │   │   ├── cz_eeg7_1.mat
  │   │   ├── cz_eeg9_1.mat
  │   │   ├── s1.mat
  |   |   ├── stft_images
  |   |        ├── .....
  |   |   ├── fsst_images
  |   |        ├── .....
  |   ├── s2
  |       ├── .....
  |
  ├── Session_2
  │   ├── s1
  │   │   ├── cz_eeg14_2.mat
  │   │   ├── cz_eeg19_2.mat
  │   │   ├── cz_eeg21_2.mat
  │   │   ├── cz_eeg4_2.mat
  │   │   ├── cz_eeg5_2.mat
  │   │   ├── cz_eeg7_2.mat
  │   │   ├── s1.mat
  |   |   ├── stft_images
  |   |       ├── .....
  |   |   ├── fsst_images
  |   |       ├── .....
  |   ├── s2
  |       ├── .....
  |
  ├── Session_3
  │   ├── s1
  │   │   ├── cz_eeg20_3.mat
  │   │   ├── cz_eeg22_3.mat
  │   │   ├── cz_eeg24_3.mat
  │   │   ├── cz_eeg12_3.mat
  │   │   ├── cz_eeg16_3.mat
  │   │   ├── cz_eeg19_3.mat
  │   │   ├── s1.mat
  |   |   ├── stft_images
  |   |       ├── .....
  |   |   ├── fsst_images
  |   |       ├── .....
  |   ├── s2
  |       ├── .....
  
