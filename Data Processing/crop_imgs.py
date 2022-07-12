#CROPIING THE IMAGES TO GET ONLY THE GRID
#importing the libararies:
import numpy as np
import cv2
import os
import moving_cropped_imgs as MVCI

#-------------------------------------- NEED TO CHANGE THE PARTICIPANT ID ACCORDINGLY -------------------------------
ROOT_PARTICIPANT = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test/subject_dependent_sst/s15/"
#--------------------------------------------------------------------------------------------------------------------

# This can be automated using a for loop however, doing so significantly increases the duration for the code to run

#SPLIT = split

def generate_cropped_imgs(ROOT_PARTICIPANT):
    for emotion in ["0_neutral", "1_sad", "2_fear", "3_happy"]:
        EMOTION_TAG = emotion
        DIR_PATH = ROOT_PARTICIPANT + '/' + EMOTION_TAG + "/"
        print(DIR_PATH)

        folder_contents = os.listdir(DIR_PATH)

        if ".DS_Store" in folder_contents:
            folder_contents.remove(".DS_Store")

        print("Length of folder_contents:", len(folder_contents))

        for img_name in folder_contents:
            print("Image Name:", img_name)
            img = cv2.imread(DIR_PATH + img_name)
            dimensions = img.shape
            print("Shape of Image:", dimensions)

            # Cropping an image
            cropped_image = img[63:784, 135:978]
            cropped_img_name = "_" + img_name

            # Display cropped image
            #cv2.imshow(cropped_img_name, cropped_image)

            # Save the cropped image
            cv2.imwrite(DIR_PATH + cropped_img_name, cropped_image)

            #cv2.waitKey(0)
            #cv2.destroyAllWindows()

        MVCI.run(DIR_PATH, EMOTION_TAG)



