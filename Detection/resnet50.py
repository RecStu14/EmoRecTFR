#!/usr/bin/env python
# coding: utf-8

# In[28]:

print("Running Code!")

#from sysconfig import get_python_version
#tensorflow_version=2.3
from re import L
import tensorflow as tf
print("TF Version:", tf.__version__)


import os

from tensorflow.keras.applications.resnet import ResNet50, preprocess_input
from tensorflow.keras.preprocessing.image import ImageDataGenerator

from tensorflow.keras.optimizers import Adam

print("Successfully imported all the libraries!")
#import matplotlib.pyplot as plt
#import datetime



# In[2]:



# In[3]:


#!pwd


# For local:
train_path = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test/subject_independent/train"
val_path = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test/subject_independent/val"
test_path = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test/subject_independent/test"

# In[ ]:


#train_path = "/home/projects/52000282/subject_dependent/s5/train"
#val_path = "/home/projects/52000282/subject_dependent/s5/val"
#test_path = "/home/projects/52000282/subject_dependent/s5/test"


# In[37]:


#initialising the generator 
train_generator = ImageDataGenerator(preprocessing_function=preprocess_input).flow_from_directory(train_path, batch_size=64, class_mode='categorical')
val_generator = ImageDataGenerator(preprocessing_function=preprocess_input).flow_from_directory(val_path, batch_size=64, class_mode='categorical')
test_generator = ImageDataGenerator(preprocessing_function=preprocess_input).flow_from_directory(test_path, batch_size=1, class_mode='categorical')


# In[38]:


print('train_generator.class_indices:\n',train_generator.class_indices)


# In[39]:


print('train_generator.labels:\n', train_generator.labels)
print("Dimension of labels:", len(train_generator.labels))


# In[40]:


#generate the size of the  train images
print('Shape of image:',train_generator.image_shape)


# In[48]:
os.chdir('/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Codes/NSCC/subject_ind/sst/try2')
print('Successfully navigated to the directory!')

model = ResNet50(weights=None, include_top=True, classes=4, input_shape=(256,256,3),classifier_activation='softmax')
model.summary()


# In[54]:


#check whether all the layers are trainable
for num, layer in enumerate(model.layers):
    print(num, "Name:", layer.name, layer.trainable)


# The above for loop shows us that all the layers of the ResNet50 are trainable. Therefore, we can start to train all the layers in ResNet50.

# #navigating to the directory to save the checkpoints in
# os.chdir('/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Codes/training/s1/ResNet50_random_weights/')

# In[17]:


#!pwd


# In[ ]:


#navigate to the folder to store the checkpoints


# # This function keeps the initial learning rate for the first ten epochs
# # and decreases it exponentially after that.
# def scheduler(epoch, lr):
#     if epoch < 10:
#         return lr
#     else:
#         return lr * tf.math.exp(-0.1)

# In[ ]:






# In[66]:


#saving the best model
check_point_best = tf.keras.callbacks.ModelCheckpoint(filepath='weights-{epoch:03d}-acc-{val_categorical_accuracy:.3f}.h5',
                                           monitor="val_categorical_accuracy", mode="max", save_best_only=True)

from tensorflow.keras.callbacks import EarlyStopping
early_stop=EarlyStopping(monitor='val_categorical_accuracy',mode='max',verbose=1,patience=6)

#lr_scheduler = tk.callbacks.LearningRateScheduler(scheduler)

#logdir = os.path.join("logs", datetime.datetime.now().strftime("%Y%m%d-%H%M%S"))
#tensorboard_callback = tf.keras.callbacks.TensorBoard(logdir, histogram_freq=1)


# In[68]:


#compiling - Adam default lr is 0.001
model.compile(loss='categorical_crossentropy',
             optimizer=Adam(),
             metrics=['categorical_accuracy'])

#history
history = model.fit(train_generator, batch_size=128, epochs=150,
                   validation_data=val_generator, callbacks=[check_point_best, early_stop])

#saving the whole model
model.save('stft_si_resnet50.h5')

#printing the summary of the model
model.summary()

#saving the history dictionary into text file
# # open file for writing
f = open("history_stft_si.txt","w")

# write file
f.write(str(history.history))

# close file
f.close()  

score = model.evaluate(test_generator)
print('Score:', score)







