#!/usr/bin/env python
# coding: utf-8

#RESNET50 MODEL TRAINING

#from sysconfig import get_python_version
#tensorflow_version=2.3
import tensorflow as tf
print("TF Version:", tf.__version__)
from tensorflow.keras.callbacks import EarlyStopping
from tensorflow.keras.applications.resnet import ResNet50, preprocess_input
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.optimizers import Adam
import os
print("Successfully imported all the libraries!")


#Directory paths to train, test and validation dataset 
train_path = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test/subject_independent/train"
val_path = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test/subject_independent/val"
test_path = "/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Datasets/try2_test/subject_independent/test"

#initialising the generator - feel free to change the batch size accordingly!
train_generator = ImageDataGenerator(preprocessing_function=preprocess_input).flow_from_directory(train_path, batch_size=64, class_mode='categorical')
val_generator = ImageDataGenerator(preprocessing_function=preprocess_input).flow_from_directory(val_path, batch_size=64, class_mode='categorical')
test_generator = ImageDataGenerator(preprocessing_function=preprocess_input).flow_from_directory(test_path, batch_size=1, class_mode='categorical')

print('train_generator.class_indices:\n',train_generator.class_indices)
print('train_generator.labels:\n', train_generator.labels)
print("Dimension of labels:", len(train_generator.labels))

#generate the size of the  train images
print('Shape of image:',train_generator.image_shape)

#Navigating to the directory in which you would like to store your saved model.
os.chdir('/Users/sankeerthana/Documents/NTU/YEAR_3/NTU_URECA/Codes/NSCC/subject_ind/sst/try2')
print('Successfully navigated to the directory!')

#Initialising the Model
model = ResNet50(weights=None, include_top=True, classes=4, input_shape=(256,256,3),classifier_activation='softmax')
model.summary()


#check whether all the layers are trainable
for num, layer in enumerate(model.layers):
    print(num, "Name:", layer.name, layer.trainable)

# The above for loop shows us that all the layers of the ResNet50 are trainable. Therefore, we can start to train all the layers in ResNet50.


#saving the best weights of the model - do note that there will be multiple weights stored if the following format is used
check_point_best = tf.keras.callbacks.ModelCheckpoint(filepath='weights-{epoch:03d}-acc-{val_categorical_accuracy:.3f}.h5',
                                           monitor="val_categorical_accuracy", mode="max", save_best_only=True)

early_stop=EarlyStopping(monitor='val_categorical_accuracy',mode='max',verbose=1,patience=6)


#OTHER CALLBACKS THAT CAN BE USED ACCORDINGLY
#lr_scheduler = tk.callbacks.LearningRateScheduler(scheduler)
#tensorboard_callback = tf.keras.callbacks.TensorBoard(logdir, histogram_freq=1)


#compiling the model - Adam default lr is 0.001
model.compile(loss='categorical_crossentropy',
             optimizer=Adam(),
             metrics=['categorical_accuracy'])

#history 
history = model.fit(train_generator, batch_size=64, epochs=150,
                   validation_data=val_generator, callbacks=[check_point_best, early_stop])

#saving the whole model
model.save('stft_s1_resnet50.h5')

#printing the summary of the model
model.summary()

#saving the history dictionary into text file to plot the loss and accuracy curves in the upcoming code.
# # open file for writing
f = open("history_stft_s1.txt","w")

# write file
f.write(str(history.history))

# close file
f.close()  

score = model.evaluate(test_generator)
print('Score:', score)

