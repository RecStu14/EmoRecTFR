#HELPER FUNCTIONS
import os

#removing .DS_Store
def remove_dsstore(contents):
    if '.DS_Store' in contents:
        contents.remove('.DS_Store')
    return contents

#deletes images in the whole directory
def delete_imgs(DIR):
    contents = os.listdir(DIR)
    for img in contents:
        if img[-4:] == '.jpg':
            file_path = os.path.join(DIR,img)
            os.remove(file_path)