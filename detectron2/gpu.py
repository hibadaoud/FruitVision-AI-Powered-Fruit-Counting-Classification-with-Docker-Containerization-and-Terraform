import tensorflow as tf

gpus = tf.config.list_physical_devices('GPU')
if gpus:
    for gpu in gpus:
        print("GPU trouvé:", tf.config.experimental.get_device_details(gpu))
else:
    print("Pas de GPU trouvé.")
