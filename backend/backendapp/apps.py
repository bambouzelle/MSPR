from django.apps import AppConfig
from tensorflow import keras
from pathlib import Path
import tensorflow as tf

class BackendappConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'backendapp'
    
    # Définition des paths des modèles
    PLANT_DETECTOR_PATH = Path("backendapp/model/plant_detector")
    SICKNESS_DETECTOR_PATH = Path("backendapp/model/sickness_detector")
    
    # Charge les modèles. En les chargeant dans ce fichier, ils sont chargés au lancement de l'app et utilisable par la suite sans avoir
    # besoin de les charger à chaque appel API
    with tf.device('/device:CPU:0'):
        plant_detector_model = keras.models.load_model(PLANT_DETECTOR_PATH)
        sickness_detector_model = keras.models.load_model(SICKNESS_DETECTOR_PATH)