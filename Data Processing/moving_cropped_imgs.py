import os
import shutil

def run(DIR_PATH, folder_name):
    folder_contents = os.listdir(DIR_PATH)

    if ".DS_Store" in folder_contents:
        folder_contents.remove(".DS_Store")

    print("Length of folder_contents:", len(folder_contents))

    cropped_imgs = []

    for file in folder_contents:
        if file[0] == "_":
            cropped_imgs.append(file)

    print("Number of cropped images:", len(cropped_imgs))

    os.mkdir(DIR_PATH + folder_name)

    for img in cropped_imgs:
        source = DIR_PATH + img
        destination = os.path.join(DIR_PATH, folder_name, img)

        shutil.move(source, destination)

        
